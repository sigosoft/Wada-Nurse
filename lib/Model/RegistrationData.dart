import 'package:image_picker/image_picker.dart';

class RegistrationData {
  final String fullname;
  final String countryCode;
  final String mobile;
  final String email;
  final String dob;
  final String gender;
  final String qualification;
  final String password;
  final String passwordConfirmation;
  final XFile image;
  final List<String> languages;
  final List<XFile> idProof;
  final List<XFile> certificates;
  final String salaryType;
  final String salary;
  final String otp;

  RegistrationData({
    required this.fullname,
    required this.countryCode,
    required this.mobile,
    required this.email,
    required this.dob,
    required this.gender,
    required this.qualification,
    required this.password,
    required this.passwordConfirmation,
    required this.image,
    required this.languages,
    required this.idProof,
    required this.certificates,
    required this.salaryType,
    required this.salary,
    required this.otp,
  });

  // Helper method to convert countryCode to int for API calls
  int get countryCodeAsInt {
    try {
      return int.parse(countryCode);
    } catch (e) {
      return 0;
    }
  }

  // Helper method to get image path as String
  String get imagePath => image.path;

  // Helper method to get first idProof path (if needed)
  String? get firstIdProofPath =>
      idProof.isNotEmpty ? idProof.first.path : null;

  // Helper method to get first certificate path (if needed)
  String? get firstCertificatePath =>
      certificates.isNotEmpty ? certificates.first.path : null;
}
