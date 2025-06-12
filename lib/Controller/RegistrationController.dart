import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:waaada_nurseapp/ApiConfigs/ApiConfigs.dart';
import 'package:waaada_nurseapp/Model/LanguageModel.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Utils/CheckNetworkConnectivity.dart';
import 'package:waaada_nurseapp/Utils/HandleDioExceptions.dart';
import 'package:waaada_nurseapp/Utils/ShowToast.dart';
import 'package:waaada_nurseapp/View/Register/Widgets/ChooseImageWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithoutPadding.dart';

Future<List<String>> _fetchCountryCodesInIsolate(String url) async {
  try {
    final dio = Dio();
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final responseData = response.data;
      final data = responseData['data'];
      if (data is Map && data.containsKey('country_codes')) {
        final countryCodesList = data['country_codes'];
        if (countryCodesList is List) {
          return countryCodesList
              .map((e) => e['country_code'].toString())
              .toSet()
              .toList()
              .cast<String>();
        }
      } else if (data is List) {
        return data
            .map((e) => e['country_code'].toString())
            .toSet()
            .toList()
            .cast<String>();
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
  List<String> countryCodes = [];
  TextEditingController phoneNumberController = TextEditingController();
  LanguageModel? languages;

  // variables should not be declared below this line

  Future<void> openCamera() async {
    try {
      cameraStatus = await Permission.camera.request();
      if (cameraStatus == PermissionStatus.granted) {
        final XFile? image = await imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: 80,
          preferredCameraDevice: CameraDevice.rear,
        );
        if (image != null) {
          selectedImage = image;
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

  Future<void> openGallery() async {
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
        selectedImage = image;
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

  showImageOptions(BuildContext context, dynamic jobDetails) {
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
                      openCamera();
                    },
                    media: media,
                    icon: Icons.camera_alt,
                    text: Strings.camera,
                  ),
                  ChooseImageWidget(
                    onTap: () {
                      openGallery();
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

  bool validateRegistrationData(
    String fullname,
    int countryCode,
    String mobile,
    String email,
    String dob,
    String gender,
    String qualification,
    String password,
    String passwordConfirmation,
  ) {
    if (fullname.isEmpty) {
      showToast("Full Name is required");
      return false;
    }
    if (countryCode == 0) {
      showToast("Country Code is required");
      return false;
    }
    return true;
  }

  Future<void> postRegistrationData(
    String fullname,
    int countryCode,
    String mobile,
    String email,
    String dob,
    String gender,
    String qualification,
    String password,
    String passwordConfirmation,
    String image,
    String idProof,
    String certificates,
    String salaryType,
    String otp,
    List<String> languages,
  ) async {
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
        "name": fullname,
        "country_code": countryCode,
        "mobile": mobile,
        "email": email,
        "dob": dob,
        "gender": gender,
        "qualification": qualification,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "languages": languages,
        "salary_type": salaryType,
        "otp": otp,
      };
      List<MapEntry<String, MultipartFile>> files = [];
      if (image.isNotEmpty) {
        files.add(
          MapEntry(
            "image",
            await MultipartFile.fromFile(
              image,
              filename: fileNameFromPath(image),
            ),
          ),
        );
      }
      if (idProof.isNotEmpty) {
        files.add(
          MapEntry(
            "id_proof",
            await MultipartFile.fromFile(
              idProof,
              filename: fileNameFromPath(idProof),
            ),
          ),
        );
      }
      if (certificates.isNotEmpty) {
        files.add(
          MapEntry(
            "certificates",
            await MultipartFile.fromFile(
              certificates,
              filename: fileNameFromPath(certificates),
            ),
          ),
        );
      }

      debugPrint("Form Map: $formMap");
      FormData data = FormData.fromMap(formMap);
      // Add files to FormData
      for (var fileEntry in files) {
        data.files.add(fileEntry);
      }
      final response = await dio.post(url, data: data);
      debugPrint("Response Data: ${response.data}");
      debugPrint("Response Status Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("Registration successful!");
        showToast("Registration successful!");
        // Handle successful registration here
        // You can add navigation or other success actions
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
}
