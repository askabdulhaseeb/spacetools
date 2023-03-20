import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacetools/provider/app_provider.dart';
import 'package:spacetools/widgets/shares.dart';
import '../Model/wallet.dart';
import '../widgets/assets.dart';
import '../widgets/custom_widget/app_bar.dart';
import '../widgets/net_worth.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.address}) : super(key: key);
  final String address;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  late Future<SolWalletData> walletFuture;
  Future<void> init() async {
    walletFuture = Provider.of<AppProvider>(context, listen: false)
        .walletData(widget.address);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: buildAppBar(context, ['Portfolio', 'Holdings'],
              address: widget.address, future: walletFuture, isEmpty: true),
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                RefreshIndicator(
                  color: Colors.white,
                  onRefresh: init,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      NetWorth(
                        walletFuture: walletFuture,
                      ),
                      Assets(
                        walletFuture: walletFuture,
                      )
                    ],
                  ),
                ),
                const Holdings()
              ]),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
