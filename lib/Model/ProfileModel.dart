// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final String status;
  final Data data;
  final String message;

  ProfileModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  final Nurse nurse;

  Data({
    required this.nurse,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    nurse: Nurse.fromJson(json["nurse"]),
  );

  Map<String, dynamic> toJson() => {
    "nurse": nurse.toJson(),
  };
}

class Nurse {
  final int id;
  final int nurseId;
  final dynamic qualification;
  final dynamic idProofUrl;
  final dynamic experience;
  final dynamic latitude;
  final dynamic longitude;
  final dynamic location;
  final dynamic healthCategories;
  final dynamic healthCategoryNames;
  final dynamic salaryType;
  final dynamic salary;
  final dynamic regPaymentId;
  final dynamic deletedAt;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic name;
  final dynamic countryCode;
  final dynamic mobile;
  final dynamic email;
  final dynamic image;
  final dynamic dob;
  final dynamic gender;
  final dynamic convertedCreatedAt;
  final List<NurseLanguage> nurseLanguages;
  final List<dynamic> nurseCertificates;

  Nurse({
    required this.id,
    required this.nurseId,
    required this.qualification,
    required this.idProofUrl,
    required this.experience,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.healthCategories,
    required this.healthCategoryNames,
    required this.salaryType,
    required this.salary,
    required this.regPaymentId,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.countryCode,
    required this.mobile,
    required this.email,
    required this.image,
    required this.dob,
    required this.gender,
    required this.convertedCreatedAt,
    required this.nurseLanguages,
    required this.nurseCertificates,
  });

  factory Nurse.fromJson(Map<String, dynamic> json) => Nurse(
    id: json["id"],
    nurseId: json["nurse_id"],
    qualification: json["qualification"],
    idProofUrl: json["id_proof_url"],
    experience: json["experience"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    location: json["location"],
    healthCategories: json["health_categories"],
    healthCategoryNames: json["health_category_names"],
    salaryType: json["salary_type"],
    salary: json["salary"],
    regPaymentId: json["reg_payment_id"],
    deletedAt: json["deleted_at"] == null ? null : DateTime.tryParse(json["deleted_at"].toString()),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null ? null : DateTime.tryParse(json["updated_at"].toString()),
    name: json["name"],
    countryCode: json["country_code"],
    mobile: json["mobile"],
    email: json["email"],
    image: json["image"],
    dob: json["dob"] == null ? null : DateTime.tryParse(json["dob"].toString()),
    gender: json["gender"],
    convertedCreatedAt: json["converted_created_at"],
    nurseLanguages: json["nurse_languages"] == null ? [] : List<NurseLanguage>.from(json["nurse_languages"].map((x) => NurseLanguage.fromJson(x))),
    nurseCertificates: json["nurse_certificates"] == null ? [] : List<dynamic>.from(json["nurse_certificates"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nurse_id": nurseId,
    "qualification": qualification,
    "id_proof_url": idProofUrl,
    "experience": experience,
    "latitude": latitude,
    "longitude": longitude,
    "location": location,
    "health_categories": healthCategories,
    "health_category_names": healthCategoryNames,
    "salary_type": salaryType,
    "salary": salary,
    "reg_payment_id": regPaymentId,
    "deleted_at": deletedAt?.toIso8601String(),
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
    "name": name,
    "country_code": countryCode,
    "mobile": mobile,
    "email": email,
    "image": image,
    "dob": dob == null ? null : "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "converted_created_at": convertedCreatedAt,
    "nurse_languages": List<dynamic>.from(nurseLanguages.map((x) => x.toJson())),
    "nurse_certificates": List<dynamic>.from(nurseCertificates.map((x) => x)),
  };
}

class NurseLanguage {
  final int id;
  final int nurseId;
  final int languageId;
  final dynamic createdAt;
  final dynamic updatedAt;

  NurseLanguage({
    required this.id,
    required this.nurseId,
    required this.languageId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NurseLanguage.fromJson(Map<String, dynamic> json) => NurseLanguage(
    id: json["id"],
    nurseId: json["nurse_id"],
    languageId: json["language_id"],
    createdAt: json["created_at"] == null ? null : DateTime.tryParse(json["created_at"].toString()),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nurse_id": nurseId,
    "language_id": languageId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
  };
}
