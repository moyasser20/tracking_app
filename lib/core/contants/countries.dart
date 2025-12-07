class Country {
  final String code;
  final String name;

  const Country({required this.code, required this.name});
}

class Countries {
  static const List<Country> countryes = [
    Country(code: "EG", name: "Egypt"),
    Country(code: "PS", name: "Palestine"),
    Country(code: "QA", name: "Qatar"),
    Country(code: "SA", name: "Saudi Arabia"),
    Country(code: "SO", name: "Somalia"),
    Country(code: "SD", name: "Sudan"),
    Country(code: "SY", name: "Syria"),
    Country(code: "TN", name: "Tunisia"),
    Country(code: "DZ", name: "Algeria"),
    Country(code: "BH", name: "Bahrain"),
    Country(code: "KM", name: "Comoros"),
    Country(code: "DJ", name: "Djibouti"),
    Country(code: "IQ", name: "Iraq"),
    Country(code: "JO", name: "Jordan"),
    Country(code: "KW", name: "Kuwait"),
    Country(code: "LB", name: "Lebanon"),
    Country(code: "LY", name: "Libya"),
    Country(code: "MR", name: "Mauritania"),
    Country(code: "MA", name: "Morocco"),
    Country(code: "OM", name: "Oman"),
    Country(code: "AE", name: "United Arab Emirates"),
    Country(code: "YE", name: "Yemen"),
  ];
}
