import 'package:flutter/material.dart';
import '../Model/coins.dart';
import '../Model/sol_top_movers.dart';
import '../Model/solana_data.dart';
import '../Services/service.dart';
import '../widgets/custom_widget/custom_sliding_text.dart';
import '../widgets/defi_charts.dart';

class Defi extends StatefulWidget {
  const Defi({Key? key, required this.address}) : super(key: key);
  final String address;

  @override
  State<Defi> createState() => _DefiState();
}

class _DefiState extends State<Defi> with AutomaticKeepAliveClientMixin<Defi> {
  late Future<Coins> coinsFuture;
  late Future<Coins> ethCoinsFuture;
  late Future<SolanaData> solanaFuture;
  late Future<SolanaData> ethFuture;
  late Future<List<SolTopMovers>> solTopMoversFuture;
  late Future<List<SolTopMovers>> ethTopMoversFuture;
  Future<void> initDefiChart() async {
    coinsFuture = coinsData();
    solanaFuture = solanaData();
    solTopMoversFuture = solTopMovers();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> initDefiChartEth() async {
    ethCoinsFuture = coinsEthData();
    ethFuture = ethData();
    ethTopMoversFuture = ethTopMovers();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    initDefiChart();
    initDefiChartEth();
    super.initState();
  }

  ValueNotifier<bool> isTapped = ValueNotifier<bool>(true);
  //bool isTapped = true;
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        DefiCharts(
          coinFuture: coinsFuture,
          solanaFuture: solanaFuture,
          solTopMoversFuture: solTopMoversFuture,
          onRefresh: initDefiChart,
          address: widget.address,
          isTapped: isTapped,
          onTap: () {
            isTapped.value = !isTapped.value;
            pageController.jumpToPage(1);
          },
          isEth: false,
        ),
        DefiCharts(
          coinFuture: ethCoinsFuture,
          solanaFuture: ethFuture,
          solTopMoversFuture: ethTopMoversFuture,
          onRefresh: initDefiChartEth,
          address: widget.address,
          isTapped: isTapped,
          onTap: () {
            isTapped.value = !isTapped.value;
            pageController.jumpToPage(0);
          },
          isEth: true,
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
