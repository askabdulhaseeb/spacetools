import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Model/wallet.dart';
import '../widgets/custom_toast.dart';

class AppProvider with ChangeNotifier {
  Future<SolWalletData> walletData(String address) async {
    final url = 'http://nft-backend.app.jsdeploy.com/processWallet/$address';
    final response = await http.get(Uri.parse(url));
    log('LOGIN ADDRESS: $address');
    log('LOGIN RESP STATUS: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      _wallet = solWalletDataFromJson(response.body);
      walletCheck = true;
    } else if (response.statusCode >= 500 && response.statusCode <= 600) {
      CustomToast.errorToast(message: 'API TimeOut');
      walletCheck = false;
    } else {
      CustomToast.errorToast(message: 'Bad Request');
      walletCheck = false;
    }
    return _wallet;
  }

  bool walletCheck = false;
  bool isok = true;
  SolWalletData _wallet = SolWalletData(
      totalBase: 0,
      totalUsdt: 0,
      changeData: ChangeData(valueChange: 0, percentChange: 0, style: 'style'),
      nativePrice: 0,
      nativeBase: 0,
      nativeUsdt: 0,
      nftBase: 0,
      nftUsdt: 0,
      tokenBase: 0,
      tokenUsdt: 0,
      nftList: [],
      tokenList: [],
      chain: 'temp1');
  SolWalletData get wallet => _wallet;
}
