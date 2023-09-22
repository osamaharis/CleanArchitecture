class Address {
  String ar;
  String en;

  Address({
    required this.ar,
    required this.en,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        ar: json["ar"],
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "ar": ar,
        "en": en,
      };
}
