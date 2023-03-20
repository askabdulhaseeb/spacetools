import 'dart:convert';

Coins coinsFromJson(String str) => Coins.fromJson(json.decode(str));

String coinsToJson(Coins data) => json.encode(data.toJson());

class Coins {
  Coins({
    required this.data,
    required this.total,
  });

  List<Datum> data;
  int total;

  factory Coins.fromJson(Map<String, dynamic> json) => Coins(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.active,
    required this.prices,
    required this.tokenId,
    required this.usdPrice,
    required this.usdPriceChange24H,
    required this.usdMarketcap,
    required this.usdVolume24H,
    required this.rank,
    required this.appTradable,
    required this.exchangeTradable,
  });

  int id;
  String name;
  String symbol;
  String slug;
  bool active;
  List<double> prices;
  int tokenId;
  double usdPrice;
  double usdPriceChange24H;
  double usdMarketcap;
  double usdVolume24H;
  int rank;
  bool appTradable;
  bool exchangeTradable;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        slug: json["slug"],
        active: json["active"],
        prices: List<double>.from(json["prices"].map((x) => x.toDouble())),
        tokenId: json["token_id"],
        usdPrice: json["usd_price"].toDouble(),
        usdPriceChange24H: json["usd_price_change_24h"].toDouble(),
        usdMarketcap: json["usd_marketcap"].toDouble(),
        usdVolume24H: json["usd_volume_24h"].toDouble(),
        rank: json["rank"],
        appTradable: json["app_tradable"],
        exchangeTradable: json["exchange_tradable"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "slug": slug,
        "active": active,
        "prices": List<dynamic>.from(prices.map((x) => x)),
        "token_id": tokenId,
        "usd_price": usdPrice,
        "usd_price_change_24h": usdPriceChange24H,
        "usd_marketcap": usdMarketcap,
        "usd_volume_24h": usdVolume24H,
        "rank": rank,
        "app_tradable": appTradable,
        "exchange_tradable": exchangeTradable,
      };
}
