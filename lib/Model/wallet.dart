// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

SolWalletData solWalletDataFromJson(String str) =>
    SolWalletData.fromJson(json.decode(str));

String solWalletDataToJson(SolWalletData data) => json.encode(data.toJson());

class SolWalletData {
  SolWalletData({
    required this.totalBase,
    required this.totalUsdt,
    required this.changeData,
    required this.nativePrice,
    required this.nativeBase,
    required this.nativeUsdt,
    required this.nftBase,
    required this.nftUsdt,
    required this.tokenBase,
    required this.tokenUsdt,
    required this.nftList,
    required this.tokenList,
    required this.chain,
  });

  double? totalBase;
  double? totalUsdt;
  ChangeData? changeData;
  double? nativePrice;
  double? nativeBase;
  double? nativeUsdt;
  double? nftBase;
  double? nftUsdt;
  num? tokenBase;
  num? tokenUsdt;
  List<NftList>? nftList;
  List<WalletTokenList>? tokenList;
  String? chain;

  factory SolWalletData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> nftData = json["nftList"] ?? [];
    final List<dynamic> tokenData = json["tokenList"] ?? [];
    final List<NftList> nfts = [];
    final List<WalletTokenList> tokensss = [];
    for (dynamic element in nftData) {
      nfts.add(NftList.fromJson(element));
    }
    for (dynamic element in tokenData) {
      tokensss.add(WalletTokenList.fromMap(element));
    }
    return SolWalletData(
      totalBase: double.parse(json["totalBase"]?.toString() ?? '0.0'),
      totalUsdt: double.parse(json["totalUsdt"]?.toString() ?? '0.0'),
      changeData: ChangeData.fromJson(json["changeData"]),
      nativePrice: double.parse(json["nativePrice"]?.toString() ?? '0'),
      nativeBase: double.parse(json["nativeBase"]?.toString() ?? '0'),
      nativeUsdt: double.parse(json["nativeUsdt"]?.toString() ?? '0'),
      nftBase: double.parse(json["nftBase"]?.toString() ?? '0.0'),
      nftUsdt: double.parse(json["nftUsdt"]?.toString() ?? '0.0'),
      tokenBase: num.parse(json["tokenBase"]?.toString() ?? '0'),
      tokenUsdt: num.parse(json["tokenUsdt"]?.toString() ?? '0'),
      nftList: json["nftList"] == null ? [] : nfts,
      tokenList: json["tokenList"] == null ? [] : tokensss,
      chain: json["chain"],
    );
  }

  Map<String, dynamic> toJson() => {
        "totalBase": totalBase,
        "totalUsdt": totalUsdt,
        "changeData": changeData?.toJson(),
        "nativePrice": nativePrice,
        "nativeBase": nativeBase,
        "nativeUsdt": nativeUsdt,
        "nftBase": nftBase,
        "nftUsdt": nftUsdt,
        "tokenBase": tokenBase,
        "tokenUsdt": tokenUsdt,
        "nftList": List<dynamic>.from(nftList!.map((x) => x.toJson())),
        "tokenList": List<dynamic>.from(tokenList!.map((x) => x)),
        "chain": chain,
      };
}

class ChangeData {
  ChangeData({
    required this.valueChange,
    required this.percentChange,
    required this.style,
  });

  double? valueChange;
  double? percentChange;
  String? style;

  factory ChangeData.fromJson(Map<String, dynamic> json) => ChangeData(
        valueChange: double.parse(json["valueChange"]?.toString() ?? '0.0'),
        percentChange: double.parse(json["percentChange"]?.toString() ?? '0.0'),
        style: json["style"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "valueChange": valueChange,
        "percentChange": percentChange,
        "style": style,
      };
}

class NftList {
  NftList({
    required this.name,
    required this.qty,
    required this.imgUrl,
    required this.floorPrice,
    required this.avgPrice24H,
    required this.collectionValue,
    required this.percentChange,
    required this.style,
    required this.items,
  });

  String? name;
  double? qty;
  String? imgUrl;
  double? floorPrice;
  double? avgPrice24H;
  double? collectionValue;
  double? percentChange;
  String? style;
  List<Item>? items;

  factory NftList.fromJson(Map<String, dynamic> json) => NftList(
        name: json["name"] ?? '',
        qty: double.parse(json["qty"]?.toString() ?? '0.0'),
        imgUrl: json["imgUrl"] ?? '',
        floorPrice: double.parse(json["floorPrice"]?.toString() ?? '0.0'),
        avgPrice24H: double.parse(json["avgPrice_24h"]?.toString() ?? '0.0'),
        collectionValue:
            double.parse(json["collectionValue"]?.toString() ?? '0.0'),
        percentChange: double.parse(json["percentChange"]?.toString() ?? '0.0'),
        style: json["style"] ?? '',
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "qty": qty,
        "imgUrl": imgUrl,
        "floorPrice": floorPrice,
        "avgPrice_24h": avgPrice24H,
        "collectionValue": collectionValue,
        "percentChange": percentChange,
        "style": style,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    required this.mintAddress,
    required this.owner,
    required this.supply,
    required this.collection,
    required this.collectionName,
    required this.name,
    required this.updateAuthority,
    required this.primarySaleHappened,
    required this.sellerFeeBasisPoints,
    required this.image,
    required this.attributes,
    required this.properties,
    required this.listStatus,
  });

  String? mintAddress;
  String? owner;
  int? supply;
  String? collection;
  String? collectionName;
  String? name;
  String? updateAuthority;
  bool primarySaleHappened;
  int? sellerFeeBasisPoints;
  String? image;
  List<Attribute>? attributes;
  Properties? properties;
  String? listStatus;

  factory Item.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> __dd = json["properties"] ?? {};
    return Item(
      mintAddress: json["mintAddress"] ?? '',
      owner: json["owner"] ?? '',
      supply: int.parse(json["supply"]?.toString() ?? '0'),
      collection: json["collection"] ?? '',
      collectionName: json["collectionName"] ?? '',
      name: json["name"] ?? '',
      updateAuthority: json["updateAuthority"] ?? '',
      primarySaleHappened: json["primarySaleHappened"] ?? false,
      sellerFeeBasisPoints:
          int.parse(json["sellerFeeBasisPoints"]?.toString() ?? '0'),
      image: json["image"] ?? '',
      attributes: List<Attribute>.from(
          json["attributes"].map((x) => Attribute.fromJson(x))),
      properties: Properties.fromJson(__dd),
      listStatus: json["listStatus"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "mintAddress": mintAddress,
        "owner": owner,
        "supply": supply,
        "collection": collection,
        "collectionName": collectionName,
        "name": name,
        "updateAuthority": updateAuthority,
        "primarySaleHappened": primarySaleHappened,
        "sellerFeeBasisPoints": sellerFeeBasisPoints,
        "image": image,
        "attributes": List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "properties": properties?.toJson(),
        "listStatus": listStatus,
      };
}

class Attribute {
  Attribute({
    required this.traitType,
    required this.value,
  });

  String? traitType;
  String? value;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        traitType: json["trait_type"] ?? '',
        value: json["value"]?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        "trait_type": traitType,
        "value": value,
      };
}

class Properties {
  Properties({
    required this.files,
    required this.category,
    required this.creators,
  });

  List<FileElement>? files;
  String? category;
  List<Creator>? creators;

  factory Properties.fromJson(Map<String, dynamic> json) {
    final String temp = json["files"].toString();
    final List<dynamic> creatorData = json["creators"] ?? [];
    final List<dynamic> filesData = temp == 'null'
        ? []
        : temp[0] == '['
            ? json["files"] ?? []
            : [json["files"]];
    final List<Creator> cre = [];
    final List<FileElement> fileess = [];
    for (dynamic element in creatorData) {
      cre.add(Creator.fromJson(element));
    }
    for (dynamic element in filesData) {
      fileess.add(FileElement.fromJson(element));
    }
    return Properties(
      files: fileess,
      category: json["category"] ?? '',
      creators: cre,
    );
  }

  Map<String, dynamic> toJson() => {
        "files": List<dynamic>.from(files!.map((x) => x.toJson())),
        "category": category,
        "creators": List<dynamic>.from(creators!.map((x) => x.toJson())),
      };
}

class Creator {
  Creator({
    required this.address,
    required this.share,
  });

  String? address;
  int? share;

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
        address: json["address"] ?? '',
        share: int.parse(json["share"]?.toString() ?? '0'),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "share": share,
      };
}

class FileElement {
  FileElement({
    required this.uri,
    required this.type,
  });

  String? uri;
  String? type;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        uri: json["uri"]?.toString() ?? '',
        type: json["type"]?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        "uri": uri,
        "type": type,
      };
}

class WalletTokenList {
  final String contractAddress;
  final String icon;
  final String symbol;
  final String name;
  final double qty;
  final double price;
  final double usdValue;
  final double volume;
  final double priceChange24h;
  final String style;

  WalletTokenList({
    required this.contractAddress,
    required this.icon,
    required this.symbol,
    required this.name,
    required this.qty,
    required this.price,
    required this.usdValue,
    required this.volume,
    required this.priceChange24h,
    required this.style,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'contractAddress': contractAddress,
      'icon': icon,
      'symbol': symbol,
      'name': name,
      'qty': qty,
      'price': price,
      'usdValue': usdValue,
      'volume': volume,
      'priceChange24h': priceChange24h,
      'style': style,
    };
  }

  factory WalletTokenList.fromMap(Map<String, dynamic> map) {
    print(map);
    return WalletTokenList(
      contractAddress: map['contractAddress'] ?? '',
      icon: map['icon'] ?? '',
      symbol: map['symbol'] ?? 'NULL',
      name: map['name'] == null || map['name'] == ''
          ? map['symbol']?.toString().toUpperCase() ?? 'name issue'
          : map['name'],
      qty: double.parse(map['qty']?.toString() ?? '0.0'),
      price: double.parse(map['price']?.toString() ?? '0.0'),
      usdValue: double.parse(map['usdValue']?.toString() ?? '0.0'),
      volume: double.parse(map['volume']?.toString() ?? '0.0'),
      priceChange24h: double.parse(map['priceChange24h']?.toString() ?? '0.0'),
      style: map['style'] ?? '',
    );
  }
}
