// ignore_for_file: prefer_if_null_operators
import 'dart:convert';

ChartData chartDataFromJson(String str) => ChartData.fromJson(json.decode(str));

String chartDataToJson(ChartData data) => json.encode(data.toJson());

class ChartData {
  ChartData({
    required this.stats,
    required this.volumeDeltas,
  });

  List<Stat> stats;
  List<double> volumeDeltas;

  factory ChartData.fromJson(Map<String, dynamic> json) => ChartData(
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        volumeDeltas:
            List<double>.from(json["volumeDeltas"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
        "volumeDeltas": List<dynamic>.from(volumeDeltas.map((x) => x)),
      };
}

class Stat {
  Stat({
    required this.bucket,
    required this.close,
    required this.open,
    required this.high,
    required this.low,
    required this.volume,
    required this.listedcount,
  });

  DateTime? bucket;
  double? close;
  double? open;
  double? high;
  double? low;
  double? volume;
  int? listedcount;

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        bucket: DateTime.parse(json["bucket"]),
        close: json["close"].toDouble(),
        open: json["open"].toDouble() == null ? null : json["open"].toDouble(),
        high: json["high"].toDouble(),
        low: json["low"].toDouble(),
        // ignore: prefer_null_aware_operators
        volume: json["volume"] == null ? null : json["volume"].toDouble(),
        listedcount: json["listedcount"],
      );

  Map<String, dynamic> toJson() => {
        "bucket": bucket?.toIso8601String(),
        "close": close,
        "open": open,
        "high": high,
        "low": low,
        "volume": volume,
        "listedcount": listedcount,
      };
}
