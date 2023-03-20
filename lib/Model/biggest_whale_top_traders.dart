import 'dart:convert';

BiggestWhalesAndTopTraders biggestWhaleAndTopTradersFromJson(String str) =>
    BiggestWhalesAndTopTraders.fromJson(json.decode(str));

String biggestWhaleAndTopTradersToJson(BiggestWhalesAndTopTraders data) =>
    json.encode(data.toJson());

class BiggestWhalesAndTopTraders {
  BiggestWhalesAndTopTraders({
    required this.listSocialItems,
  });

  List<ListSocialItem> listSocialItems;

  factory BiggestWhalesAndTopTraders.fromJson(Map<String, dynamic> json) =>
      BiggestWhalesAndTopTraders(
        listSocialItems: List<ListSocialItem>.from(
            json["listSocialItems"].map((x) => ListSocialItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listSocialItems":
            List<dynamic>.from(listSocialItems.map((x) => x.toJson())),
      };
}

class ListSocialItem {
  ListSocialItem({
    required this.actor,
    required this.totalPortfolioValueUsd,
    required this.nftPortfolioValueUsd,
    required this.nftPortfolioValueSol,
    required this.splTokenPortfolioValueUsd,
    required this.lastTransactionBlocktime,
    required this.lastTransactionDirection,
    required this.lastTransactionPriceSol,
    required this.lastTransactionCollectionId,
    required this.lastWashTradeTransactionBlocktime,
    required this.lastWashTradeTransactionDirection,
    required this.lastWashTradeTransactionPriceSol,
    required this.lastWashTradeTransactionCollectionId,
    required this.collectionName,
    required this.slug,
    required this.profileImageUrl,
  });

  Actor? actor;
  double? totalPortfolioValueUsd;
  double? nftPortfolioValueUsd;
  double? nftPortfolioValueSol;
  double? splTokenPortfolioValueUsd;
  int? lastTransactionBlocktime;
  LastTransactionDirection? lastTransactionDirection;
  double? lastTransactionPriceSol;
  String? lastTransactionCollectionId;
  dynamic lastWashTradeTransactionBlocktime;
  dynamic lastWashTradeTransactionDirection;
  dynamic lastWashTradeTransactionPriceSol;
  dynamic lastWashTradeTransactionCollectionId;
  String? collectionName;
  String? slug;
  String? profileImageUrl;

  factory ListSocialItem.fromJson(Map<String, dynamic> json) => ListSocialItem(
        actor: Actor.fromJson(json["actor"]),
        totalPortfolioValueUsd: json["totalPortfolioValueUSD"].toDouble(),
        nftPortfolioValueUsd: json["nftPortfolioValueUSD"].toDouble(),
        nftPortfolioValueSol: json["nftPortfolioValueSOL"].toDouble(),
        splTokenPortfolioValueUsd: json["splTokenPortfolioValueUSD"].toDouble(),
        lastTransactionBlocktime: json["lastTransactionBlocktime"],
        lastTransactionDirection: lastTransactionDirectionValues
            .map[json["lastTransactionDirection"]],
        lastTransactionPriceSol: json["lastTransactionPriceSOL"].toDouble(),
        lastTransactionCollectionId: json["lastTransactionCollectionId"],
        lastWashTradeTransactionBlocktime:
            json["lastWashTradeTransactionBlocktime"],
        lastWashTradeTransactionDirection:
            json["lastWashTradeTransactionDirection"],
        lastWashTradeTransactionPriceSol:
            json["lastWashTradeTransactionPriceSOL"],
        lastWashTradeTransactionCollectionId:
            json["lastWashTradeTransactionCollectionId"],
        collectionName: json["collectionName"],
        slug: json["slug"],
        profileImageUrl: json["profileImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "actor": actor?.toJson(),
        "totalPortfolioValueUSD": totalPortfolioValueUsd,
        "nftPortfolioValueUSD": nftPortfolioValueUsd,
        "nftPortfolioValueSOL": nftPortfolioValueSol,
        "splTokenPortfolioValueUSD": splTokenPortfolioValueUsd,
        "lastTransactionBlocktime": lastTransactionBlocktime,
        "lastTransactionDirection":
            lastTransactionDirectionValues.reverse[lastTransactionDirection],
        "lastTransactionPriceSOL": lastTransactionPriceSol,
        "lastTransactionCollectionId": lastTransactionCollectionId,
        "lastWashTradeTransactionBlocktime": lastWashTradeTransactionBlocktime,
        "lastWashTradeTransactionDirection": lastWashTradeTransactionDirection,
        "lastWashTradeTransactionPriceSOL": lastWashTradeTransactionPriceSol,
        "lastWashTradeTransactionCollectionId":
            lastWashTradeTransactionCollectionId,
        "collectionName": collectionName,
        "slug": slug,
        "profileImageUrl": profileImageUrl,
      };
}

class Actor {
  Actor({
    required this.twitterName,
    required this.twitterId,
    required this.twitterHandle,
    required this.followersCount,
  });

  String? twitterName;
  String? twitterId;
  String? twitterHandle;
  String? followersCount;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        twitterName: json["twitterName"],
        twitterId: json["twitterId"],
        twitterHandle: json["twitterHandle"],
        followersCount: json["followersCount"],
      );

  Map<String, dynamic> toJson() => {
        "twitterName": twitterName,
        "twitterId": twitterId,
        "twitterHandle": twitterHandle,
        "followersCount": followersCount,
      };
}

enum LastTransactionDirection { bought, sold }

final lastTransactionDirectionValues = EnumValues({
  "bought": LastTransactionDirection.bought,
  "sold": LastTransactionDirection.sold
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
