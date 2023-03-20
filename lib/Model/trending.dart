import 'dart:convert';

List<TrendingData> trendingDataFromJson(String str) => List<TrendingData>.from(
    json.decode(str).map((x) => TrendingData.fromJson(x)));

String trendingDataToJson(List<TrendingData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrendingData {
  TrendingData(
      {required this.rank,
      required this.color,
      required this.name,
      required this.mcap,
      required this.image,
      required this.floor,
      required this.tenMinFloor,
      required this.volume,
      required this.shortName});

  String rank;
  ColorValues? color;
  String name;
  int mcap;
  String image;
  String floor;
  String tenMinFloor;
  num? volume;
  String shortName;

  factory TrendingData.fromJson(Map<String, dynamic> json) => TrendingData(
      rank: json["rank"],
      color: colorValues.map[json["color"]],
      name: json["name"],
      mcap: json["mcap"],
      image: json["image"],
      floor: json["floor"],
      tenMinFloor: json["tenMinFloor"],
      volume: json["volume"],
      shortName: json["shortName"]);

  Map<String, dynamic> toJson() => {
        "rank": rank,
        "color": colorValues.reverse[color],
        "name": name,
        "mcap": mcap,
        "image": image,
        "floor": floor,
        "tenMinFloor": tenMinFloor,
        "volume": volume,
        "shortName": shortName
      };
}

enum ColorValues { f73c63, the20EFB9, gray }

final colorValues = EnumValues({
  "#F73C63": ColorValues.f73c63,
  "#20efb9": ColorValues.the20EFB9,
  'gray': ColorValues.gray
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}
