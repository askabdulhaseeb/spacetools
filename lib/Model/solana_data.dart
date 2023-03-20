import 'dart:convert';

SolanaData solanaDataFromJson(String str) =>
    SolanaData.fromJson(json.decode(str));

String solanaDataToJson(SolanaData data) => json.encode(data.toJson());

class SolanaData {
  SolanaData({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data data;

  factory SolanaData.fromJson(Map<String, dynamic> json) => SolanaData(
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.tagCode,
    required this.marketCap,
    required this.tradeVolume,
    required this.marketCapChangeRate,
    required this.tradeVolumeChangeRate,
    required this.samples,
  });

  String tagCode;
  double marketCap;
  double tradeVolume;
  double marketCapChangeRate;
  double tradeVolumeChangeRate;
  List<Sample> samples;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tagCode: json["tag_code"],
        marketCap: json["market_cap"].toDouble(),
        tradeVolume: json["trade_volume"].toDouble(),
        marketCapChangeRate: json["market_cap_change_rate"].toDouble(),
        tradeVolumeChangeRate: json["trade_volume_change_rate"].toDouble(),
        samples:
            List<Sample>.from(json["samples"].map((x) => Sample.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tag_code": tagCode,
        "market_cap": marketCap,
        "trade_volume": tradeVolume,
        "market_cap_change_rate": marketCapChangeRate,
        "trade_volume_change_rate": tradeVolumeChangeRate,
        "samples": List<dynamic>.from(samples.map((x) => x.toJson())),
      };
}

class Sample {
  Sample({
    required this.time,
    required this.marketCap,
    required this.tradeVolume,
  });

  int time;
  double marketCap;
  double tradeVolume;

  factory Sample.fromJson(Map<String, dynamic> json) => Sample(
        time: json["time"],
        marketCap: json["market_cap"].toDouble(),
        tradeVolume: json["trade_volume"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "market_cap": marketCap,
        "trade_volume": tradeVolume,
      };
}
