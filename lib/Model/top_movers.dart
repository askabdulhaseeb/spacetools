import 'dart:convert';

TopMoversData topMoversDataFromJson(String str) =>
    TopMoversData.fromJson(json.decode(str));

String topMoversDataToJson(TopMoversData data) => json.encode(data.toJson());

class TopMoversData {
  TopMoversData({
    required this.nfts,
    required this.nextPageToken,
  });

  List<Nft> nfts;
  String nextPageToken;

  factory TopMoversData.fromJson(Map<String, dynamic> json) => TopMoversData(
        nfts: List<Nft>.from(json["nfts"].map((x) => Nft.fromJson(x))),
        nextPageToken: json["nextPageToken"],
      );

  Map<String, dynamic> toJson() => {
        "nfts": List<dynamic>.from(nfts.map((x) => x.toJson())),
        "nextPageToken": nextPageToken,
      };
}

class Nft {
  Nft({
    required this.id,
    required this.name,
    required this.sampleImageUrl,
    required this.slug,
    required this.supply,
    required this.currentOwnerCount,
    required this.avgUsdcBalance,
    required this.proportionOwningSolanaMonkeyBusiness,
    required this.avgPriceSol,
    required this.avgPriceUsd,
    required this.magicEdenHolding,
    required this.magicEdenHoldingProportion,
    required this.marketCapSol,
    required this.marketCapUsd,
    required this.mintPriceMode,
    required this.listingCount,
    required this.averageWashScore,
    required this.minWashScore,
    required this.maxWashScore,
    required this.washIndexDescription,
    required this.smartNetflowScore30Min,
    required this.smartNetflowScore1Hr,
    required this.smartNetflowScore6Hr,
    required this.smartNetflowScore12Hr,
    required this.smartNetflowScore,
    required this.smartNetflowScore7Day,
    required this.smartNetflowScore1Month,
    required this.narrative,
    required this.externalUrl,
    required this.avgPriceNow1Hour,
    required this.avgPriceNow6Hour,
    required this.avgPriceNow12Hour,
    required this.avgPriceNow1Month,
    required this.avgPriceNow1Week,
    required this.avgPriceNow30Minutes,
    required this.volume,
    required this.volumeChange,
    required this.volumeDelta,
    required this.floorPrice,
    required this.floorPriceDelta,
    required this.floorPriceChange,
    required this.usdPerSol,
    required this.usdPerSolLastUpdated,
    required this.countBuyers30Minutes,
    required this.countSellers30Minutes,
    required this.countBuyers1Hour,
    required this.countSellers1Hour,
    required this.countBuyers6Hr,
    required this.countSellers6Hr,
    required this.countBuyers12Hr,
    required this.countSellers12Hr,
    required this.cntBuyers1D,
    required this.cntSellers1D,
    required this.countBuyers1Week,
    required this.countSellers1Week,
    required this.countBuyers1Month,
    required this.countSellers1Month,
  });

  String? id;
  String? name;
  String? sampleImageUrl;
  String? slug;
  int? supply;
  int? currentOwnerCount;
  int? avgUsdcBalance;
  double? proportionOwningSolanaMonkeyBusiness;
  double? avgPriceSol;
  double? avgPriceUsd;
  int? magicEdenHolding;
  double? magicEdenHoldingProportion;
  double? marketCapSol;
  double? marketCapUsd;
  dynamic mintPriceMode;
  int? listingCount;
  int? averageWashScore;
  int? minWashScore;
  int? maxWashScore;
  WashIndexDescription? washIndexDescription;
  dynamic smartNetflowScore30Min;
  dynamic smartNetflowScore1Hr;
  dynamic smartNetflowScore6Hr;
  dynamic smartNetflowScore12Hr;
  double? smartNetflowScore;
  dynamic smartNetflowScore7Day;
  dynamic smartNetflowScore1Month;
  String? narrative;
  String? externalUrl;
  dynamic avgPriceNow1Hour;
  dynamic avgPriceNow6Hour;
  dynamic avgPriceNow12Hour;
  dynamic avgPriceNow1Month;
  dynamic avgPriceNow1Week;
  dynamic avgPriceNow30Minutes;
  double? volume;
  dynamic volumeChange;
  double? volumeDelta;
  double? floorPrice;
  double? floorPriceDelta;
  double? floorPriceChange;
  double? usdPerSol;
  int? usdPerSolLastUpdated;
  dynamic countBuyers30Minutes;
  dynamic countSellers30Minutes;
  dynamic countBuyers1Hour;
  dynamic countSellers1Hour;
  dynamic countBuyers6Hr;
  dynamic countSellers6Hr;
  dynamic countBuyers12Hr;
  dynamic countSellers12Hr;
  dynamic cntBuyers1D;
  dynamic cntSellers1D;
  dynamic countBuyers1Week;
  dynamic countSellers1Week;
  dynamic countBuyers1Month;
  dynamic countSellers1Month;

  factory Nft.fromJson(Map<String, dynamic> json) => Nft(
        id: json["id"],
        name: json["name"],
        sampleImageUrl: json["sampleImageUrl"],
        slug: json["slug"],
        supply: json["supply"],
        currentOwnerCount: json["currentOwnerCount"],
        avgUsdcBalance: json["avgUsdcBalance"],
        proportionOwningSolanaMonkeyBusiness:
            json["proportion_owning_solana_monkey_business"] == null
                ? null
                : json["proportion_owning_solana_monkey_business"].toDouble(),
        avgPriceSol:
            json["avgPriceSol"] == null ? null : json["avgPriceSol"].toDouble(),
        avgPriceUsd:
            json["avgPriceUsd"] == null ? null : json["avgPriceUsd"].toDouble(),
        magicEdenHolding: json["magicEdenHolding"],
        magicEdenHoldingProportion: json["magicEdenHoldingProportion"] == null
            ? null
            : json["magicEdenHoldingProportion"].toDouble(),
        marketCapSol: json["marketCapSol"] == null
            ? null
            : json["marketCapSol"].toDouble(),
        marketCapUsd: json["marketCapUsd"] == null
            ? null
            : json["marketCapUsd"].toDouble(),
        mintPriceMode: json["mintPriceMode"],
        listingCount: json["listingCount"],
        averageWashScore: json["averageWashScore"],
        minWashScore: json["minWashScore"],
        maxWashScore: json["maxWashScore"],
        washIndexDescription: json["washIndexDescription"] == null
            ? null
            : washIndexDescriptionValues.map[json["washIndexDescription"]],
        smartNetflowScore30Min: json["smartNetflowScore30min"],
        smartNetflowScore1Hr: json["smartNetflowScore1hr"],
        smartNetflowScore6Hr: json["smartNetflowScore6hr"],
        smartNetflowScore12Hr: json["smartNetflowScore12hr"],
        smartNetflowScore: json["smartNetflowScore"] == null
            ? null
            : json["smartNetflowScore"].toDouble(),
        smartNetflowScore7Day: json["smartNetflowScore7day"],
        smartNetflowScore1Month: json["smartNetflowScore1Month"],
        narrative: json["narrative"],
        externalUrl: json["externalUrl"],
        avgPriceNow1Hour: json["avgPriceNow1Hour"],
        avgPriceNow6Hour: json["avgPriceNow6Hour"],
        avgPriceNow12Hour: json["avgPriceNow12Hour"],
        avgPriceNow1Month: json["avgPriceNow1Month"],
        avgPriceNow1Week: json["avgPriceNow1Week"],
        avgPriceNow30Minutes: json["avgPriceNow30Minutes"],
        volume: json["volume"] == null ? null : json["volume"].toDouble(),
        volumeChange: json["volumeChange"],
        volumeDelta:
            json["volumeDelta"] == null ? null : json["volumeDelta"].toDouble(),
        floorPrice:
            json["floorPrice"] == null ? null : json["floorPrice"].toDouble(),
        floorPriceDelta: json["floorPriceDelta"] == null
            ? null
            : json["floorPriceDelta"].toDouble(),
        floorPriceChange: json["floorPriceChange"] == null
            ? null
            : json["floorPriceChange"].toDouble(),
        usdPerSol:
            json["usdPerSol"] == null ? null : json["usdPerSol"].toDouble(),
        usdPerSolLastUpdated: json["usdPerSolLastUpdated"],
        countBuyers30Minutes: json["countBuyers30minutes"],
        countSellers30Minutes: json["countSellers30minutes"],
        countBuyers1Hour: json["countBuyers1Hour"],
        countSellers1Hour: json["countSellers1Hour"],
        countBuyers6Hr: json["countBuyers6hr"],
        countSellers6Hr: json["countSellers6hr"],
        countBuyers12Hr: json["countBuyers12hr"],
        countSellers12Hr: json["countSellers12hr"],
        cntBuyers1D: json["cntBuyers1d"],
        cntSellers1D: json["cntSellers1d"],
        countBuyers1Week: json["countBuyers1Week"],
        countSellers1Week: json["countSellers1Week"],
        countBuyers1Month: json["countBuyers1Month"],
        countSellers1Month: json["countSellers1Month"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sampleImageUrl": sampleImageUrl,
        "slug": slug,
        "supply": supply,
        "currentOwnerCount": currentOwnerCount,
        "avgUsdcBalance": avgUsdcBalance,
        "proportion_owning_solana_monkey_business":
            proportionOwningSolanaMonkeyBusiness,
        "avgPriceSol": avgPriceSol,
        "avgPriceUsd": avgPriceUsd,
        "magicEdenHolding": magicEdenHolding,
        "magicEdenHoldingProportion": magicEdenHoldingProportion,
        "marketCapSol": marketCapSol,
        "marketCapUsd": marketCapUsd,
        "mintPriceMode": mintPriceMode,
        "listingCount": listingCount,
        "averageWashScore": averageWashScore,
        "minWashScore": minWashScore,
        "maxWashScore": maxWashScore,
        "washIndexDescription": washIndexDescription == null
            ? null
            : washIndexDescriptionValues.reverse[washIndexDescription],
        "smartNetflowScore30min": smartNetflowScore30Min,
        "smartNetflowScore1hr": smartNetflowScore1Hr,
        "smartNetflowScore6hr": smartNetflowScore6Hr,
        "smartNetflowScore12hr": smartNetflowScore12Hr,
        "smartNetflowScore": smartNetflowScore,
        "smartNetflowScore7day": smartNetflowScore7Day,
        "smartNetflowScore1Month": smartNetflowScore1Month,
        "narrative": narrative,
        "externalUrl": externalUrl,
        "avgPriceNow1Hour": avgPriceNow1Hour,
        "avgPriceNow6Hour": avgPriceNow6Hour,
        "avgPriceNow12Hour": avgPriceNow12Hour,
        "avgPriceNow1Month": avgPriceNow1Month,
        "avgPriceNow1Week": avgPriceNow1Week,
        "avgPriceNow30Minutes": avgPriceNow30Minutes,
        "volume": volume,
        "volumeChange": volumeChange,
        "volumeDelta": volumeDelta,
        "floorPrice": floorPrice,
        "floorPriceDelta": floorPriceDelta,
        "floorPriceChange": floorPriceChange,
        "usdPerSol": usdPerSol,
        "usdPerSolLastUpdated": usdPerSolLastUpdated,
        "countBuyers30minutes": countBuyers30Minutes,
        "countSellers30minutes": countSellers30Minutes,
        "countBuyers1Hour": countBuyers1Hour,
        "countSellers1Hour": countSellers1Hour,
        "countBuyers6hr": countBuyers6Hr,
        "countSellers6hr": countSellers6Hr,
        "countBuyers12hr": countBuyers12Hr,
        "countSellers12hr": countSellers12Hr,
        "cntBuyers1d": cntBuyers1D,
        "cntSellers1d": cntSellers1D,
        "countBuyers1Week": countBuyers1Week,
        "countSellers1Week": countSellers1Week,
        "countBuyers1Month": countBuyers1Month,
        "countSellers1Month": countSellers1Month,
      };
}

enum WashIndexDescription { noneSuspected, highSuspected }

final washIndexDescriptionValues = EnumValues({
  "High suspected": WashIndexDescription.highSuspected,
  "None suspected": WashIndexDescription.noneSuspected
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
