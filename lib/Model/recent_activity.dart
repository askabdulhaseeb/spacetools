import 'dart:convert';

RecentActivityData recentActivityFromJson(String str) =>
    RecentActivityData.fromJson(json.decode(str));

String recentActivityToJson(RecentActivityData data) =>
    json.encode(data.toJson());

class RecentActivityData {
  RecentActivityData({
    required this.socialActivities,
  });

  List<SocialActivity> socialActivities;

  factory RecentActivityData.fromJson(Map<String, dynamic> json) =>
      RecentActivityData(
        socialActivities: List<SocialActivity>.from(
            json["socialActivities"].map((x) => SocialActivity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "socialActivities":
            List<dynamic>.from(socialActivities.map((x) => x.toJson())),
      };
}

class SocialActivity {
  SocialActivity({
    required this.activityId,
    required this.transaction,
    required this.actor,
    required this.totalPortfolioValueUsd,
    required this.nftProfitAndLossSol,
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
    required this.nftRoi,
    required this.listing,
  });

  String? activityId;
  Transaction? transaction;
  SocialActivityActor? actor;
  int? totalPortfolioValueUsd;
  double? nftProfitAndLossSol;
  double? nftPortfolioValueUsd;
  double? nftPortfolioValueSol;
  double? splTokenPortfolioValueUsd;
  int? lastTransactionBlocktime;
  String? lastTransactionDirection;
  double? lastTransactionPriceSol;
  String? lastTransactionCollectionId;
  dynamic lastWashTradeTransactionBlocktime;
  dynamic lastWashTradeTransactionDirection;
  dynamic lastWashTradeTransactionPriceSol;
  dynamic lastWashTradeTransactionCollectionId;
  String? collectionName;
  String? slug;
  String? profileImageUrl;
  double? nftRoi;
  SocialActivityListing? listing;

  factory SocialActivity.fromJson(Map<String, dynamic> json) => SocialActivity(
        activityId: json["activityId"],
        transaction: json["transaction"] == null
            ? null
            : Transaction.fromJson(json["transaction"]),
        actor: SocialActivityActor.fromJson(json["actor"]),
        totalPortfolioValueUsd: json["totalPortfolioValueUSD"],
        nftProfitAndLossSol: json["nftProfitAndLossSOL"].toDouble(),
        nftPortfolioValueUsd: json["nftPortfolioValueUSD"] == null
            ? null
            : json["nftPortfolioValueUSD"].toDouble(),
        nftPortfolioValueSol: json["nftPortfolioValueSOL"] == null
            ? null
            : json["nftPortfolioValueSOL"].toDouble(),
        splTokenPortfolioValueUsd: json["splTokenPortfolioValueUSD"].toDouble(),
        lastTransactionBlocktime: json["lastTransactionBlocktime"],
        lastTransactionDirection: json["lastTransactionDirection"],
        lastTransactionPriceSol: json["lastTransactionPriceSOL"] == null
            ? null
            : json["lastTransactionPriceSOL"].toDouble(),
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
        nftRoi: json["nftROI"] == null ? null : json["nftROI"].toDouble(),
        listing: json["listing"] == null
            ? null
            : SocialActivityListing.fromJson(json["listing"]),
      );

  Map<String, dynamic> toJson() => {
        "activityId": activityId,
        "transaction": transaction == null ? null : transaction?.toJson(),
        "actor": actor?.toJson(),
        "totalPortfolioValueUSD": totalPortfolioValueUsd,
        "nftProfitAndLossSOL": nftProfitAndLossSol,
        "nftPortfolioValueUSD": nftPortfolioValueUsd,
        "nftPortfolioValueSOL": nftPortfolioValueSol,
        "splTokenPortfolioValueUSD": splTokenPortfolioValueUsd,
        "lastTransactionBlocktime": lastTransactionBlocktime,
        "lastTransactionDirection": lastTransactionDirection,
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
        "nftROI": nftRoi,
        "listing": listing == null ? null : listing?.toJson(),
      };
}

class SocialActivityActor {
  SocialActivityActor({
    required this.twitterId,
    required this.twitterHandle,
  });

  String? twitterId;
  String? twitterHandle;

  factory SocialActivityActor.fromJson(Map<String, dynamic> json) =>
      SocialActivityActor(
        twitterId: json["twitterId"],
        twitterHandle: json["twitterHandle"],
      );

  Map<String, dynamic> toJson() => {
        "twitterId": twitterId,
        "twitterHandle": twitterHandle,
      };
}

class SocialActivityListing {
  SocialActivityListing({
    required this.listing,
    required this.actor,
  });

  ListingListing? listing;
  PrimaryActorClass? actor;

  factory SocialActivityListing.fromJson(Map<String, dynamic> json) =>
      SocialActivityListing(
        listing: ListingListing.fromJson(json["listing"]),
        actor: PrimaryActorClass.fromJson(json["actor"]),
      );

  Map<String, dynamic> toJson() => {
        "listing": listing?.toJson(),
        "actor": actor?.toJson(),
      };
}

class PrimaryActorClass {
  PrimaryActorClass({
    required this.id,
    required this.twitter,
    required this.name,
    required this.twitterId,
    required this.twitterImage,
    required this.followers,
    required this.following,
  });

  String? id;
  String? twitter;
  String? name;
  String? twitterId;
  String? twitterImage;
  int? followers;
  int? following;

  factory PrimaryActorClass.fromJson(Map<String, dynamic> json) =>
      PrimaryActorClass(
        id: json["id"],
        twitter: json["twitter"],
        name: json["name"],
        twitterId: json["twitter_id"],
        twitterImage: json["twitter_image"],
        followers: json["followers"],
        following: json["following"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "twitter": twitter,
        "name": name,
        "twitter_id": twitterId,
        "twitter_image": twitterImage,
        "followers": followers,
        "following": following,
      };
}

class ListingListing {
  ListingListing({
    required this.priceSol,
    required this.nft,
    required this.type,
    required this.market,
    required this.time,
    required this.maskedTransactionId,
  });

  double? priceSol;
  Nft? nft;
  Type? type;
  String? market;
  String? time;
  String? maskedTransactionId;

  factory ListingListing.fromJson(Map<String, dynamic> json) => ListingListing(
        priceSol: json["priceSol"].toDouble(),
        nft: Nft.fromJson(json["nft"]),
        type: typeValues.map[json["type"]],
        market: json["market"],
        time: json["time"],
        maskedTransactionId: json["maskedTransactionId"],
      );

  Map<String, dynamic> toJson() => {
        "priceSol": priceSol,
        "nft": nft?.toJson(),
        "type": typeValues.reverse[type],
        "market": market,
        "time": time,
        "maskedTransactionId": maskedTransactionId,
      };
}

enum Type { cancel, create }

final typeValues = EnumValues({"CANCEL": Type.cancel, "CREATE": Type.create});

class Nft {
  Nft({
    required this.id,
    required this.name,
    required this.slug,
    required this.collectionImageUri,
  });

  String? id;
  String? name;
  String? slug;
  String? collectionImageUri;

  factory Nft.fromJson(Map<String, dynamic> json) => Nft(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        collectionImageUri: json["collectionImageUri"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "collectionImageUri": collectionImageUri,
      };
}

class Transaction {
  Transaction({
    required this.primaryActor,
    required this.saleType,
    required this.collectionName,
    required this.transactionTime,
    required this.price,
    required this.collectionSlug,
    required this.maskedTransactionId,
  });

  PrimaryActorClass? primaryActor;
  SaleType? saleType;
  String? collectionName;
  String? transactionTime;
  String? price;
  String? collectionSlug;
  String? maskedTransactionId;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        primaryActor: PrimaryActorClass.fromJson(json["primaryActor"]),
        saleType: saleTypeValues.map[json["saleType"]],
        collectionName: json["collectionName"],
        transactionTime: json["transactionTime"],
        price: json["price"],
        collectionSlug: json["collectionSlug"],
        maskedTransactionId: json["maskedTransactionId"],
      );

  Map<String, dynamic> toJson() => {
        "primaryActor": primaryActor?.toJson(),
        "saleType": saleTypeValues.reverse[saleType],
        "collectionName": collectionName,
        "transactionTime": transactionTime,
        "price": price,
        "collectionSlug": collectionSlug,
        "maskedTransactionId": maskedTransactionId,
      };
}

enum SaleType { buyer, seller }

final saleTypeValues =
    EnumValues({"BUYER": SaleType.buyer, "SELLER": SaleType.seller});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}
