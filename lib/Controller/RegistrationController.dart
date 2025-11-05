import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:waaada_nurseapp/ApiConfigs/ApiConfigs.dart';
import 'package:waaada_nurseapp/Model/LanguageModel.dart';
import 'package:waaada_nurseapp/Model/CountryCodeModel.dart';
import 'package:waaada_nurseapp/Model/RegistrationData.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Utils/CheckNetworkConnectivity.dart';
import 'package:waaada_nurseapp/Utils/HandleDioExceptions.dart';
import 'package:waaada_nurseapp/Utils/ShowToast.dart';
import 'package:waaada_nurseapp/View/Home/Home.dart';
import 'package:waaada_nurseapp/View/OtpVerification/Otpverification.dart';
import 'package:waaada_nurseapp/View/Register/DocumentationUploadScreen.dart';
import 'package:waaada_nurseapp/View/Register/Widgets/ChooseImageWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithoutPadding.dart';

Future<List<CountryCode>> _fetchCountryCodesInIsolate(String url) async {
  try {
    final dio = Dio();
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final responseData = response.data;
      final data = responseData['data'];
      final Set<String> seenCodes = {};
      final List<CountryCode> countryCodes = [];

      if (data is Map && data.containsKey('country_codes')) {
        final countryCodesList = data['country_codes'];
        if (countryCodesList is List) {
          for (var e in countryCodesList) {
            final countryCode = CountryCode.fromJson(e as Map<String, dynamic>);
            if (!seenCodes.contains(countryCode.countryCode)) {
              seenCodes.add(countryCode.countryCode);
              countryCodes.add(countryCode);
            }
          }
          return countryCodes;
        }
      } else if (data is List) {
        for (var e in data) {
          final countryCode = CountryCode.fromJson(e as Map<String, dynamic>);
          if (!seenCodes.contains(countryCode.countryCode)) {
            seenCodes.add(countryCode.countryCode);
            countryCodes.add(countryCode);
          }
        }
        return countryCodes;
      }
    }
    return [];
  } catch (e) {
    debugPrint("Error in isolate: $e");
    return [];
  }
}

class RegistrationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    debugPrint("RegistrationController initialized");
  }

  @override
  void onClose() {
    debugPrint("RegistrationController disposed");
    super.onClose();
  }

  // variables should be declared above this line

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  bool isObscureNewPassword = true;
  bool isObscureConfirmPassword = true;
  List<String> selectedLanguages = [];
  Language? selectedLanguage;
  String? selectedGender;
  String selectedType = "";
  PermissionStatus cameraStatus = PermissionStatus.denied;
  PermissionStatus photosStatus = PermissionStatus.denied;
  XFile? selectedImage;
  String? pickedImage;
  final ImagePicker imagePicker = ImagePicker();
  final Dio dio = Dio();
  bool isLoading = false;
  List<CountryCode> countryCodes = [];
  int? selectedCountryCodeId;
  TextEditingController phoneNumberController = TextEditingController();
  LanguageModel? languages;
  DateTime? selectedDateOfBirth;
  List<XFile> idProofImages = [];
  List<XFile> certificatesImages = [];
  String? otp;
  double registrationFee = 0.0;
  // variables should not be declared below this line

  void onDateSelected(DateTime? date) {
    debugPrint("onDateSelected called with date: $date");
    if (date != null) {
      final normalizedDate = DateTime(date.year, date.month, date.day);
      final today = DateTime.now();
      final normalizedToday = DateTime(today.year, today.month, today.day);

      debugPrint("onDateSelected - Normalized date: $normalizedDate");
      debugPrint("onDateSelected - Normalized today: $normalizedToday");

      if (normalizedDate.isAfter(normalizedToday) ||
          normalizedDate.isAtSameMomentAs(normalizedToday)) {
        debugPrint("onDateSelected - Date is today or in future, rejecting");
        showToast(
          "Date of birth cannot be today or in the future",
          isError: true,
        );
        return;
      }

      final maxAllowedDate = DateTime(
        normalizedToday.year - 18,
        normalizedToday.month,
        normalizedToday.day,
      );

      debugPrint("onDateSelected - Max allowed date: $maxAllowedDate");
      debugPrint(
        "onDateSelected - Is date after max allowed? ${normalizedDate.isAfter(maxAllowedDate)}",
      );

      if (normalizedDate.isAfter(maxAllowedDate)) {
        debugPrint(
          "onDateSelected - Date is less than 18 years old, rejecting",
        );
        showToast("Minimum age should be 18 years", isError: true);
        return;
      }

      debugPrint(
        "onDateSelected - Date validation passed, setting selectedDateOfBirth",
      );
    }
    selectedDateOfBirth = date;
    debugPrint(
      "onDateSelected - selectedDateOfBirth set to: $selectedDateOfBirth",
    );
    update();
  }

  Future<void> openCamera({bool? isIdProof, bool? isCertificates}) async {
    try {
      cameraStatus = await Permission.camera.request();
      if (cameraStatus == PermissionStatus.granted) {
        final XFile? image = await imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: 80,
          preferredCameraDevice: CameraDevice.rear,
        );
        if (image != null) {
          if (isIdProof ?? false) {
            if (idProofImages.length >= 5) {
              showToast("Maximum 5 ID proof photos allowed", isError: true);
              return;
            }
            idProofImages.add(image);
          } else if (isCertificates ?? false) {
            if (certificatesImages.length >= 5) {
              showToast("Maximum 5 certificates photos allowed", isError: true);
              return;
            }
            certificatesImages.add(image);
          } else {
            selectedImage = image;
          }
          debugPrint("Image captured from camera: ${image.path}");
          Get.back();
          pickedImage = image.path;
          update();
        }
      } else {
        showToast("Camera permission is required to capture photos");
      }
    } catch (e) {
      debugPrint("Error capturing image: $e");
      showToast("Failed to open camera: ${e.toString()}");
    }
  }

  Future<bool> requestStoragePermission() async {
    try {
      Permission permission = Permission.photos;
      PermissionStatus status = await permission.status;
      if (status.isGranted) {
        photosStatus = PermissionStatus.granted;
        return true;
      }
      if (status.isPermanentlyDenied) {
        showToast(
          "Storage permission is permanently denied. Please enable it from app settings.",
          isError: true,
        );
        await openAppSettings();
        return false;
      }
      photosStatus = await permission.request();
      if (photosStatus.isGranted) {
        return true;
      } else if (photosStatus.isPermanentlyDenied) {
        showToast(
          "Storage permission is permanently denied. Please enable it from app settings.",
          isError: true,
        );
        await openAppSettings();
        return false;
      } else {
        showToast(
          "Permission is required to access photos from gallery",
          isError: true,
        );
        return false;
      }
    } catch (e) {
      debugPrint("Error requesting storage permission: $e");
      try {
        photosStatus = await Permission.storage.request();
        if (photosStatus.isGranted) {
          return true;
        } else if (photosStatus.isPermanentlyDenied) {
          debugPrint(
            "Storage permission is permanently denied. Please enable it from app settings.",
          );
          showToast(
            "Storage permission is permanently denied. Please enable it from app settings.",
            isError: true,
          );
          await openAppSettings();
          return false;
        } else {
          showToast(
            "Permission is required to access photos from gallery",
            isError: true,
          );
          return false;
        }
      } catch (e2) {
        debugPrint("Error requesting storage permission fallback: $e2");
      }
      showToast(
        "Failed to request storage permission: ${e.toString()}",
        isError: true,
      );
      return false;
    }
  }

  Future<void> openGallery({bool? isIdProof, bool? isCertificates}) async {
    try {
      bool hasPermission = await requestStoragePermission();
      if (!hasPermission) {
        return;
      }
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        if (isIdProof ?? false) {
          if (idProofImages.isNotEmpty && idProofImages.length >= 1) {
            showToast("Maximum 1 ID proof photos allowed", isError: true);
            return;
          }
          if (idProofImages.contains(image)) {
            showToast("ID proof already uploaded", isError: true);
            return;
          }
          idProofImages.add(image);
        } else if (isCertificates ?? false) {
          if (certificatesImages.length >= 5) {
            showToast("Maximum 5 certificates photos allowed", isError: true);
            return;
          }
          if (certificatesImages.contains(image)) {
            showToast("Certificate already uploaded", isError: true);
            return;
          }
          certificatesImages.add(image);
        } else {
          selectedImage = image;
        }
        debugPrint("Image selected from gallery: ${image.path}");
        Get.back();
        pickedImage = image.path;
        update();
      }
    } catch (e) {
      debugPrint("Error selecting image: $e");
      showToast("Failed to open gallery: ${e.toString()}", isError: true);
    }
  }

  showImageOptions(
    BuildContext context, {
    XFile? image,
    bool? isIdProof,
    bool? isCertificates,
    List<XFile>? imagesList,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final media = MediaQuery.of(context).size;
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: TextStyleInterWithoutPadding(
            text: Strings.selectPhotoFrom,
            color: colorPrimary,
            size: 18,
            fontWeight: FontWeight.w700,
          ),
          actionsPadding: EdgeInsets.symmetric(
            horizontal: media.width * 0.025,
            vertical: media.height * 0.005,
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: media.width * 0.020,
                vertical: media.height * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChooseImageWidget(
                    onTap: () {
                      openCamera(
                        isIdProof: isIdProof,
                        isCertificates: isCertificates,
                      );
                    },
                    media: media,
                    icon: Icons.camera_alt,
                    text: Strings.camera,
                  ),
                  ChooseImageWidget(
                    onTap: () {
                      openGallery(
                        isIdProof: isIdProof,
                        isCertificates: isCertificates,
                      );
                    },
                    media: media,
                    icon: Icons.photo_library,
                    text: Strings.gallery,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> getCountryCodes() async {
    isLoading = true;
    update();
    checkNetworkAndRedirectOffAll();
    try {
      String url = ApiConfigs.baseUrl + APIEndpoints.getCountryCodes;
      debugPrint("URL: $url");
      countryCodes = await compute(_fetchCountryCodesInIsolate, url);
      if (countryCodes.isEmpty) {
        debugPrint("No country codes retrieved from API");
      } else {
        debugPrint("Successfully fetched ${countryCodes.length} country codes");
      }
    } catch (e) {
      debugPrint("Error fetching country codes: $e");
      countryCodes = [];
      showToast(
        "Failed to load country codes. Please try again.",
        isError: true,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getLanguages() async {
    isLoading = true;
    checkNetworkAndRedirectOffAll();
    try {
      String url = ApiConfigs.baseUrl + APIEndpoints.getLanguages;
      dio.options.queryParameters = {};
      debugPrint("URL: $url");
      debugPrint("Query Parameters: ${dio.options.queryParameters}");
      final response = await dio.get(url);
      debugPrint("Response: ${response.data}");
      if (response.statusCode == 200) {
        languages = LanguageModel.fromJson(response.data);
        update();
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        handleDioException(e);
      } else {
        debugPrint("Dio Exception without response: ${e.message}");
      }
    } catch (e) {
      debugPrint("Unexpected Error: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  bool navigatingToNextPage({
    required String fullname,
    required String countryCode,
    required String mobile,
    required String email,
    required String dob,
    required String gender,
    required String qualification,
    required String password,
    required String passwordConfirmation,
    required String image,
    required List<String> languages,
  }) {
    debugPrint("fullname: $fullname");
    debugPrint("countryCode: $countryCode");
    debugPrint("mobile: $mobile");
    debugPrint("email: $email");
    debugPrint("dob: $dob");
    debugPrint("gender: $gender");
    debugPrint("qualification: $qualification");
    debugPrint("password: $password");
    debugPrint("passwordConfirmation: $passwordConfirmation");
    debugPrint("image: $image");
    debugPrint("languages: $languages");
    if (email.isNotEmpty) {
      final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );
      if (!emailRegex.hasMatch(email)) {
        showToast("Enter a valid email address", isError: true);
        return false;
      }
    }
    if (mobile.isNotEmpty) {
      if (mobile.length != 10) {
        showToast("Enter a valid mobile number", isError: true);
        return false;
      }
    }
    if (password.isNotEmpty) {
      if (password.length < 8) {
        showToast("Password must be at least 8 characters long", isError: true);
        return false;
      }
    }
    if (passwordConfirmation.isNotEmpty) {
      if (passwordConfirmation != password) {
        showToast("Password and confirm password do not match", isError: true);
        return false;
      }
    }
    if (image.isEmpty) {
      showToast("Please upload a profile photo", isError: true);
      return false;
    }
    Get.to(
      () => DocumentationUploadScreen(
        image: XFile(image),
        fullName: fullname,
        countryCode: countryCode,
        phoneNumber: mobile,
        email: email,
        dateOfBirth: dob,
        gender: gender,
        qualification: qualification,
        languages: languages,
        password: password,
        confirmPassword: passwordConfirmation,
        otp: otp.toString(),
      ),
    );
    return true;
  }

  void validateRegister(RegistrationData data) {
    debugPrint("fullname: ${data.fullname}");
    debugPrint("countryCode: ${data.countryCode}");
    debugPrint("mobile: ${data.mobile}");
    debugPrint("email: ${data.email}");
    debugPrint("dob: ${data.dob}");
    debugPrint("gender: ${data.gender}");
    debugPrint("qualification: ${data.qualification}");
    debugPrint("password: ${data.password}");
    debugPrint("passwordConfirmation: ${data.passwordConfirmation}");
    debugPrint("image: ${data.image.path}");
    debugPrint("languages: ${data.languages}");
    debugPrint("idProof: ${data.idProof}");
    debugPrint("certificates: ${data.certificates}");
    debugPrint("salaryType: ${data.salaryType}");
    debugPrint("otp: ${data.otp}");
    if (data.idProof.isEmpty) {
      showToast("Please upload ID proof", isError: true);
      return;
    }
    if (data.certificates.isEmpty) {
      showToast("Please upload certificates", isError: true);
      return;
    }
    sendRegisterOtp(
      mobile: data.mobile,
      countryCode: data.countryCode,
      registrationData: data,
    );
  }

  Future<void> postRegistrationData(RegistrationData data) async {
    isLoading = true;
    checkNetworkAndRedirectOffAll();
    try {
      String url = ApiConfigs.baseUrl + APIEndpoints.register;
      debugPrint("URL: $url");
      String fileNameFromPath(String path) {
        if (path.isEmpty) return "";
        var normalized = path.replaceAll('\\\\', '/');
        var parts = normalized.split('/');
        return parts.isNotEmpty ? parts.last : "";
      }

      Map<String, dynamic> formMap = {
        "name": data.fullname,
        "country_code": data.countryCodeAsInt,
        "mobile": data.mobile,
        "email": data.email,
        "dob": data.dob,
        "gender": data.gender,
        "qualification": data.qualification,
        "password": data.password,
        "password_confirmation": data.passwordConfirmation,
        "languages": data.languages,
        "salary_type": data.salaryType == "Salaried Employee" ? "1" : "2",
        "otp": data.otp,
      };
      List<MapEntry<String, MultipartFile>> files = [];
      if (data.imagePath.isNotEmpty) {
        files.add(
          MapEntry(
            "image",
            await MultipartFile.fromFile(
              data.imagePath,
              filename: fileNameFromPath(data.imagePath),
            ),
          ),
        );
      }
      if (data.idProof.isNotEmpty) {
        for (var idProofFile in data.idProof) {
          files.add(
            MapEntry(
              "id_proof",
              await MultipartFile.fromFile(
                idProofFile.path,
                filename: fileNameFromPath(idProofFile.path),
              ),
            ),
          );
        }
      }
      if (data.certificates.isNotEmpty) {
        for (var certificateFile in data.certificates) {
          files.add(
            MapEntry(
              "certificates",
              await MultipartFile.fromFile(
                certificateFile.path,
                filename: fileNameFromPath(certificateFile.path),
              ),
            ),
          );
        }
      }

      debugPrint("Form Map: $formMap");
      FormData formData = FormData.fromMap(formMap);
      for (var fileEntry in files) {
        formData.files.add(fileEntry);
      }
      final response = await dio.post(url, data: formData);
      debugPrint("Response Data: ${response.data}");
      debugPrint("Response Status Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("Registration successful!");
        showToast("Registration successful!");
        Get.offAll(() => Home());
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        handleDioException(e);
      } else {
        debugPrint("Dio Exception without response: ${e.message}");
      }
    } catch (e, stackTrace) {
      debugPrint("Unexpected Error: $e");
      debugPrint("Stack Trace: $stackTrace");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getRegistrationFee() async {
    isLoading = true;
    checkNetworkAndRedirectOffAll();
    try {
      String url = ApiConfigs.baseUrl + APIEndpoints.getRegistrationFee;
      dio.options.queryParameters = {};
      debugPrint("URL: $url");
      debugPrint("Query Parameters: ${dio.options.queryParameters}");
      final response = await dio.get(url);
      debugPrint("Response: ${response.data}");
      if (response.statusCode == 200) {
        final fee = response.data['data']?['registration_fee'];
        if (fee != null) {
          registrationFee = (fee is num) ? fee.toDouble() : 0.0;
        } else {
          registrationFee = 0.0;
        }
        update();
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        handleDioException(e);
      } else {
        debugPrint("Dio Exception without response: ${e.message}");
      }
      registrationFee = 0.0;
      update();
    } catch (e) {
      debugPrint("Unexpected Error: $e");
      registrationFee = 0.0;
      update();
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> sendRegisterOtp({
    required String mobile,
    required String countryCode,
    required RegistrationData registrationData,
  }) async {
    isLoading = true;
    checkNetworkAndRedirectOffAll();
    try {
      String url = ApiConfigs.baseUrl + APIEndpoints.sendRegisterOtp;
      dio.options.queryParameters = {};
      debugPrint("URL: $url");
      debugPrint("Query Parameters: ${dio.options.queryParameters}");
      final response = await dio.post(
        url,
        data: {"country_code": countryCode, "mobile": mobile},
      );
      debugPrint(
        "Data Sent: ${{"country_code": countryCode, "mobile": mobile}}",
      );
      debugPrint("Response: ${response.data}");
      if (response.statusCode == 200) {
        Get.to(() => OtpVerification(registrationData: registrationData));
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        handleDioException(e);
      } else {
        debugPrint("Dio Exception without response: ${e.message}");
      }
    } catch (e) {
      debugPrint("Unexpected Error: $e");
    } finally {}
  }
}
