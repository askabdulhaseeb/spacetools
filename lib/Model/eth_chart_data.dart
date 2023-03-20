import 'dart:convert';

EthChartData ethChartDataFromJson(String str) =>
    EthChartData.fromJson(json.decode(str));

class EthChartData {
  EthChartData({
    required this.code,
    required this.data,
  });

  int code;
  Data data;

  factory EthChartData.fromJson(Map<String, dynamic> json) => EthChartData(
        code: json["code"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.owner,
    required this.volume,
    required this.sale,
    required this.averagePrices,
    required this.owners,
    required this.marketCaps,
    required this.volumes,
    required this.sales,
    required this.averagePrice,
    required this.marketCap,
    required this.totalVolume,
    required this.floorPrice,
  });

  int? owner;
  double? volume;
  int? sale;
  List<double>? averagePrices;
  List<int>? owners;
  List<double>? marketCaps;
  List<double>? volumes;
  List<int>? sales;
  double? averagePrice;
  double? marketCap;
  double? totalVolume;
  double? floorPrice;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        owner: json["owner"],
        volume: json["volume"] == null ? null : json["volume"].toDouble(),
        sale: json["sale"],
        averagePrices: json["averagePrices"] == null
            ? null
            : List<double>.from(json["averagePrices"].map((x) => x.toDouble())),
        owners: json["owners"] == null
            ? null
            : List<int>.from(json["owners"].map((x) => x)),
        marketCaps: json["marketCaps"] == null
            ? null
            : List<double>.from(json["marketCaps"].map((x) => x.toDouble())),
        volumes: json["volumes"] == null
            ? null
            : List<double>.from(json["volumes"].map((x) => x.toDouble())),
        sales: json["sales"] == null
            ? null
            : List<int>.from(json["sales"].map((x) => x)),
        averagePrice: json["average_price"] == null
            ? null
            : json["average_price"].toDouble(),
        marketCap:
            json["market_cap"] == null ? null : json["market_cap"].toDouble(),
        totalVolume: json["total_volume"] == null
            ? null
            : json["total_volume"].toDouble(),
        floorPrice:
            json["floor_price"] == null ? null : json["floor_price"].toDouble(),
      );
}
