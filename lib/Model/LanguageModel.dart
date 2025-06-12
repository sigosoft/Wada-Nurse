class LanguageModel {
  final bool? status;
  final LanguageData? data;
  final String? message;

  LanguageModel({
    this.status,
    this.data,
    this.message,
  });

  factory LanguageModel.fromJson(Map<String, dynamic>? json) {
    return LanguageModel(
      status: json?['status'] == "true" || json?['status'] == true,
      data: json?['data'] != null ? LanguageData.fromJson(json?['data']) : null,
      message: json?['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status ?? false,
      'data': data?.toJson() ?? {},
      'message': message ?? '',
    };
  }
}

class LanguageData {
  final List<Language>? languages;

  LanguageData({this.languages});

  factory LanguageData.fromJson(Map<String, dynamic>? json) {
    var list = json?['languages'] as List<dynamic>? ?? [];
    return LanguageData(
      languages: list.map((e) => Language.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'languages': languages?.map((e) => e.toJson()).toList() ?? [],
    };
  }
}

class Language {
  final int? id;
  final String? language;

  Language({
    this.id,
    this.language,
  });

  factory Language.fromJson(Map<String, dynamic>? json) {
    return Language(
      id: json?['id'] ?? 0,
      language: json?['language'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'language': language ?? '',
    };
  }
}
