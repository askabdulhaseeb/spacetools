import 'dart:convert';

List<SolTopMovers> solTopMoversFromJson(String str) => List<SolTopMovers>.from(
    json.decode(str).map((x) => SolTopMovers.fromJson(x)));

String solTopMoversToJson(List<SolTopMovers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SolTopMovers {
  SolTopMovers({
    required this.name,
    required this.symbol,
    required this.slug,
    required this.prices,
    required this.tokenId,
    required this.usdPrice,
    required this.usdPriceChange24H,
  });

  String name;
  String symbol;
  String slug;
  List<double> prices;
  int tokenId;
  double usdPrice;
  double usdPriceChange24H;

  factory SolTopMovers.fromJson(Map<String, dynamic> json) => SolTopMovers(
        name: json["name"],
        symbol: json["symbol"],
        slug: json["slug"],
        prices: List<double>.from(json["prices"].map((x) => x.toDouble())),
        tokenId: json["token_id"],
        usdPrice: json["usd_price"].toDouble(),
        usdPriceChange24H: json["usd_price_change_24h"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
        "slug": slug,
        "prices": List<dynamic>.from(prices.map((x) => x)),
        "token_id": tokenId,
        "usd_price": usdPrice,
        "usd_price_change_24h": usdPriceChange24H,
      };
}
