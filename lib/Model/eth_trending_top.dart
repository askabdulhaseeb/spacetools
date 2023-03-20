import 'dart:convert';

List<EthTrendingTop> ethTrendingFromJson(String str) =>
    List<EthTrendingTop>.from(
        json.decode(str).map((x) => EthTrendingTop.fromJson(x)));

String ethTrendingToJson(List<EthTrendingTop> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EthTrendingTop {
  EthTrendingTop({
    required this.name,
    required this.image,
    required this.circulatingSupply,
    required this.floor,
    required this.floorChange,
    required this.floorChangeColor,
    required this.sales,
    required this.salesChange,
    required this.salesChangeColor,
    required this.average,
    required this.averageChange,
    required this.averageChangeColor,
    required this.mcap,
    required this.mcapChange,
    required this.mcapChangeColor,
    required this.volume,
    required this.volumeChange,
    required this.volumeChangeColor,
  });

  String? name;
  String? image;
  String? circulatingSupply;
  String? floor;
  String? floorChange;
  ChangeColor? floorChangeColor;
  String? sales;
  String? salesChange;
  ChangeColor? salesChangeColor;
  String? average;
  String? averageChange;
  ChangeColor? averageChangeColor;
  double? mcap;
  String? mcapChange;
  ChangeColor? mcapChangeColor;
  double? volume;
  String? volumeChange;
  ChangeColor? volumeChangeColor;

  factory EthTrendingTop.fromJson(Map<String, dynamic> json) => EthTrendingTop(
        name: json["name"],
        image: json["image"],
        circulatingSupply: json["circulatingSupply"],
        floor: json["floor"],
        floorChange: json["floorChange"],
        floorChangeColor: json["floorChangeColor"] == null
            ? null
            : changeColorValues.map[json["floorChangeColor"]],
        sales: json["sales"],
        salesChange: json["salesChange"],
        salesChangeColor: json["salesChangeColor"] == null
            ? null
            : changeColorValues.map[json["salesChangeColor"]],
        average: json["average"],
        averageChange: json["averageChange"],
        averageChangeColor: json["averageChangeColor"] == null
            ? null
            : changeColorValues.map[json["averageChangeColor"]],
        mcap: json["mcap"],
        mcapChange: json["mcapChange"],
        mcapChangeColor: json["mcapChangeColor"] == null
            ? null
            : changeColorValues.map[json["mcapChangeColor"]],
        volume: json["volume"] == null ? null : json["volume"].toDouble(),
        volumeChange: json["volumeChange"],
        volumeChangeColor: json["volumeChangeColor"] == null
            ? null
            : changeColorValues.map[json["volumeChangeColor"]],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "circulatingSupply": circulatingSupply,
        "floor": floor,
        "floorChange": floorChange,
        "floorChangeColor": floorChangeColor == null
            ? null
            : changeColorValues.reverse[floorChangeColor],
        "sales": sales,
        "salesChange": salesChange,
        "salesChangeColor": salesChangeColor == null
            ? null
            : changeColorValues.reverse[salesChangeColor],
        "average": average,
        "averageChange": averageChange,
        "averageChangeColor": averageChangeColor == null
            ? null
            : changeColorValues.reverse[averageChangeColor],
        "mcap": mcap,
        "mcapChange": mcapChange,
        "mcapChangeColor": mcapChangeColor == null
            ? null
            : changeColorValues.reverse[mcapChangeColor],
        "volume": volume,
        "volumeChange": volumeChange,
        "volumeChangeColor": volumeChangeColor == null
            ? null
            : changeColorValues.reverse[volumeChangeColor],
      };
}

enum ChangeColor { red, gray, green }

final changeColorValues = EnumValues({
  "gray": ChangeColor.gray,
  "green": ChangeColor.green,
  "red": ChangeColor.red
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
