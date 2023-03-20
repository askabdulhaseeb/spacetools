import 'dart:convert';
import 'package:spacetools/Model/eth_trending_top.dart';
import '../Model/biggest_whale_top_traders.dart';
import '../Model/calendar.dart';
import '../Model/recent_activity.dart';
import '../Model/sol_top_movers.dart';
import '../Model/solana_data.dart';
import '../Model/wallet.dart';
import '../Model/chart_data.dart';
import '../Model/coins.dart';
import '../Model/top_movers.dart';
import '../Model/trending.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://space-app.xyz/solana_api/showJson.php?file=';

Future<TopMoversData> topMoversData() async {
  const url = '${baseUrl}topMovers';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return topMoversDataFromJson(response.body);
  } else {
    throw Exception('failed to load topMovers');
  }
}

// Future<List<EthTopMovers>> ethTopMoversData() async {
//   const url = '${baseUrl}icyToolsTop';
//   final response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     return ethTopMoversFromJson(response.body);
//   } else {
//     throw Exception('failed to load');
//   }
// }

Future<RecentActivityData> recentActivityData() async {
  const url = '${baseUrl}recent-activity';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return recentActivityFromJson(response.body);
  } else {
    throw Exception('failed to load');
  }
}

Future<BiggestWhalesAndTopTraders> biggestWhalesData() async {
  const url = '${baseUrl}biggest-whales';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return biggestWhaleAndTopTradersFromJson(response.body);
  } else {
    throw Exception('failed to load');
  }
}

Future<BiggestWhalesAndTopTraders> topTradersData() async {
  const url = '${baseUrl}top-traders';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return biggestWhaleAndTopTradersFromJson(response.body);
  } else {
    throw Exception('failed to load');
  }
}

Future<List<TrendingData>> tenMinTrendingData() async {
  const url = '${baseUrl}tenMinTrending';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return trendingDataFromJson(response.body);
  } else {
    throw Exception('failed to load');
  }
}

Future<List<EthTrendingTop>> ethTopMoversData() async {
  const url = '${baseUrl}ethTop';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return ethTrendingFromJson(response.body);
  } else {
    throw Exception('failed to load');
  }
}

Future<List<EthTrendingTop>> ethTrendingData() async {
  const url = '${baseUrl}ethTrending';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return ethTrendingFromJson(response.body);
  } else {
    throw Exception('failed to load');
  }
}

Future ethChartData(String slug) async {
  final url =
      'https://price-api.crypto.com/nft/v2/collection/sales/$slug/?page=1&limit=10&blockchain=0';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return [];
  }
}

Future<ChartData> chartData(String shortName) async {
  final url = '$baseUrl$shortName';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return chartDataFromJson(response.body);
  } else {
    throw Exception('failed to load');
  }
}

Future<List<Calendar>> calendarData() async {
  const url = '${baseUrl}calenderSOL';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return calendarFromJson(response.body);
  } else {
    throw Exception('failed to load');
  }
}

Future<List<Calendar>> ethCalendarData() async {
  const url = '${baseUrl}nftDropsCalenderETH';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return calendarFromJson(response.body);
  } else {
    throw Exception('failed to load');
  }
}

Future<Coins> coinsData() async {
  const url = '${baseUrl}solana-ecosystem-tokens';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return coinsFromJson(response.body);
  } else {
    throw Exception('failed to load');
  }
}

Future<Coins> coinsEthData() async {
  const url = '${baseUrl}ethereum-ecosystem-tokens';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return coinsFromJson(response.body);
  } else {
    throw Exception('failed to load');
  }
}

Future<SolanaData> solanaData() async {
  const url = '${baseUrl}solana-ecosystem';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return solanaDataFromJson(response.body);
  } else {
    throw Exception('failed to load');
  }
}

Future<SolanaData> ethData() async {
  const url = '${baseUrl}ethereum-ecosystem';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return solanaDataFromJson(response.body);
  } else {
    throw Exception('failed to load');
  }
}

Future<List<SolTopMovers>> solTopMovers() async {
  const url = '${baseUrl}solana-ecosystem-topmovers';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return solTopMoversFromJson(response.body);
  } else {
    throw Exception('failed to load');
  }
}

Future<List<SolTopMovers>> ethTopMovers() async {
  const url = '${baseUrl}ethereum-ecosystem-topmovers';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return solTopMoversFromJson(response.body);
  } else {
    throw Exception('failed to load');
  }
}

Future<List> refPrice({double? totalWorth, required String chain}) async {
  final url =
      'http://nft-backend.app.jsdeploy.com/refPrice/$chain/${totalWorth ?? ''}';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('failed to load');
  }
}

// Future<SolWalletData> walletData(String address) async {
//   final url = 'http://sol-nft-scanner.app.jsdeploy.com/processWallet/$address';
//   final response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200 || response.statusCode == 201) {
//     return solWalletDataFromJson(response.body);
//   } else {
//     throw Exception('failed to load');
//   }
// }
