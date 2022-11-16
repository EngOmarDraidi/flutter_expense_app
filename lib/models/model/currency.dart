class Currency {
  String? code;
  String? country;

  Currency.fromJSON(Map<String, dynamic> data) {
    code = data['code'];
    country = data['country'];
  }

  Map<String, dynamic> toJSON() {
    return {
      'code': code,
      'country': country,
    };
  }
}
