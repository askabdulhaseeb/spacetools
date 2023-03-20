import 'dart:convert';

SolananaWeeklyPrice solanaWeeklyPriceFromJson(String str) =>
    SolananaWeeklyPrice.fromJson(json.decode(str));

class SolananaWeeklyPrice {
  SolananaWeeklyPrice({
    required this.status,
    required this.data,
  });

  bool status;
  Data data;

  factory SolananaWeeklyPrice.fromJson(Map<String, dynamic> json) =>
      SolananaWeeklyPrice(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.values,
    required this.periodChange,
  });

  Map<String, double> values;
  double periodChange;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        values: Map.from(json["values"])
            .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        periodChange: json["period_change"].toDouble(),
      );
}
