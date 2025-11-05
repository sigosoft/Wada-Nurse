class CountryCode {
  final int id;
  final String countryCode;

  CountryCode({
    required this.id,
    required this.countryCode,
  });

  factory CountryCode.fromJson(Map<String, dynamic> json) {
    return CountryCode(
      id: json['id'] ?? 0,
      countryCode: json['country_code']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country_code': countryCode,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CountryCode && other.id == id && other.countryCode == countryCode;
  }

  @override
  int get hashCode => id.hashCode ^ countryCode.hashCode;
}

