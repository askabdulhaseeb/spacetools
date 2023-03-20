import 'dart:convert';

List<LastSoldActivities> lastSoldActivitiesFromJson(String str) =>
    List<LastSoldActivities>.from(
        json.decode(str).map((x) => LastSoldActivities.fromJson(x)));

String lastSoldActivitiesToJson(List<LastSoldActivities> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LastSoldActivities {
  LastSoldActivities({
    required this.owner,
    required this.seller,
    required this.image,
    required this.symbol,
    required this.marketplace,
    required this.signature,
    required this.creators,
    required this.sellerFeeBasisPoints,
    required this.slot,
    required this.type,
    required this.buyer,
    required this.mint,
    required this.signatureStatus,
    required this.tokenAccount,
    required this.storageMetaUrl,
    required this.amountInLamports,
    required this.name,
    required this.currency,
    required this.timestamp,
    required this.measureName,
    required this.time,
    required this.measureValueDouble,
    required this.blocktime,
    required this.amount,
    required this.moonrankRank,
    required this.listingId,
    required this.howrareRank,
    required this.auctionHouseAuthority,
  });

  String owner;
  String seller;
  String image;
  String symbol;
  Marketplace? marketplace;
  String signature;
  String creators;
  String sellerFeeBasisPoints;
  String slot;
  Type? type;
  String buyer;
  String mint;
  SignatureStatus? signatureStatus;
  String tokenAccount;
  String storageMetaUrl;
  String amountInLamports;
  String name;
  Currency? currency;
  String timestamp;
  MeasureName? measureName;
  DateTime? time;
  double measureValueDouble;
  int blocktime;
  double amount;
  String moonrankRank;
  String listingId;
  String howrareRank;
  String auctionHouseAuthority;

  factory LastSoldActivities.fromJson(Map<String, dynamic> json) =>
      LastSoldActivities(
        owner: json["owner"],
        seller: json["seller"],
        image: json["image"],
        symbol: json["symbol"],
        marketplace: marketplaceValues.map[json["marketplace"]],
        signature: json["signature"],
        creators: json["creators"],
        sellerFeeBasisPoints: json["sellerFeeBasisPoints"],
        slot: json["slot"],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        buyer: json["buyer"],
        mint: json["mint"],
        signatureStatus: json["signatureStatus"] == null
            ? null
            : signatureStatusValues.map[json["signatureStatus"]],
        tokenAccount: json["tokenAccount"],
        storageMetaUrl: json["storageMetaUrl"],
        amountInLamports: json["amountInLamports"],
        name: json["name"],
        currency: json["currency"] == null
            ? null
            : currencyValues.map[json["currency"]],
        timestamp: json["timestamp"],
        measureName: json["measure_name"] == null
            ? null
            : measureNameValues.map[json["measure_name"]],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        measureValueDouble: json["measure_value::double"] == null
            ? null
            : json["measure_value::double"].toDouble(),
        blocktime: json["blocktime"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        moonrankRank: json["moonrankRank"],
        listingId: json["listingId"],
        howrareRank: json["howrareRank"],
        auctionHouseAuthority: json["auctionHouseAuthority"],
      );

  Map<String, dynamic> toJson() => {
        "owner": owner,
        "seller": seller,
        "image": image,
        "symbol": symbol,
        "marketplace": marketplaceValues.reverse[marketplace],
        "signature": signature,
        "creators": creators,
        "sellerFeeBasisPoints": sellerFeeBasisPoints,
        "slot": slot,
        "type": type == null ? null : typeValues.reverse[type],
        "buyer": buyer,
        "mint": mint,
        "signatureStatus": signatureStatus == null
            ? null
            : signatureStatusValues.reverse[signatureStatus],
        "tokenAccount": tokenAccount,
        "storageMetaUrl": storageMetaUrl,
        "amountInLamports": amountInLamports,
        "name": name,
        "currency": currency == null ? null : currencyValues.reverse[currency],
        "timestamp": timestamp,
        "measure_name":
            measureName == null ? null : measureNameValues.reverse[measureName],
        "time": time == null ? null : time?.toIso8601String(),
        "measure_value::double": measureValueDouble,
        "blocktime": blocktime,
        "amount": amount,
        "moonrankRank": moonrankRank,
        "listingId": listingId,
        "howrareRank": howrareRank,
        "auctionHouseAuthority": auctionHouseAuthority,
      };
}

enum Currency { sol }

final currencyValues = EnumValues({"SOL": Currency.sol});

enum Marketplace { magicEden, yawww, auctionHouse }

final marketplaceValues = EnumValues({
  "AuctionHouse": Marketplace.auctionHouse,
  "MagicEden": Marketplace.magicEden,
  "Yawww": Marketplace.yawww
});

enum MeasureName { price }

final measureNameValues = EnumValues({"price": MeasureName.price});

enum SignatureStatus { confirmed }

final signatureStatusValues =
    EnumValues({"confirmed": SignatureStatus.confirmed});

enum Type { sold }

final typeValues = EnumValues({"SOLD": Type.sold});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}
