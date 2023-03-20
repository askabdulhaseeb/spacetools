import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Model/wallet.dart';
import '../Services/service.dart';
import '../constants.dart';
import '../widgets/live_list.dart';

Map<String, bool> buttons = {
  '1D': true,
  '1W': false,
  '1M': false,
  '1Y': false,
  'All': false,
};

class NetWorth extends StatelessWidget {
  const NetWorth({
    Key? key,
    required this.walletFuture,
  }) : super(key: key);
  final Future<SolWalletData> walletFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SolWalletData>(
        future: walletFuture,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Net Worth',
                        style: textTheme(context).labelMedium,
                      ),
                      Label(
                        text:
                            '${data?.changeData?.percentChange?.toStringAsFixed(2).substring((data.changeData?.percentChange ?? 0) > 0 ? 0 : 1)}% (\$${data?.changeData?.valueChange?.toStringAsFixed(2).substring((data.changeData?.valueChange ?? 0) > 0 ? 0 : 1)})',
                        icon: checkCoinIcon(
                            data!.changeData?.percentChange.toString() ?? '0'),
                        color: checkCoinColor(
                            data.changeData?.percentChange.toString() ?? '0'),
                        boxColor: checkCoinColor(
                            data.changeData?.percentChange.toString() ?? '0'),
                        opacity: .1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Token Worth',
                            style: textTheme(context).labelMedium,
                          ),
                          Row(
                            children: [
                              checkCoinIcon(
                                  data.changeData?.percentChange.toString() ??
                                      '0'),
                              Text(
                                '\$${NumberFormat().format(data.nativeUsdt! + data.tokenUsdt!)}',
                                style: TextStyle(
                                    color: checkCoinColor(data
                                            .changeData?.percentChange
                                            .toString() ??
                                        '0')),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text:
                                  '\$${NumberFormat().format(double.parse(data.totalUsdt.toString().substring(0, data.totalUsdt.toString().indexOf('.'))))}',
                              style: const TextStyle(
                                  fontSize: 48, color: Colors.white)),
                          TextSpan(
                              text: data.totalUsdt
                                  ?.toStringAsFixed(2)
                                  .substring(
                                      data.totalUsdt.toString().indexOf('.')),
                              style: TextStyle(
                                  fontSize: 48,
                                  color: kGreyColor.withOpacity(.25)))
                        ])),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'NFTs Worth',
                            style: textTheme(context).labelMedium,
                          ),
                          Row(
                            children: [
                              !nftWorthCheck(data)
                                  ? const Icon(
                                      Icons.arrow_drop_up,
                                      size: 18,
                                      color: kGreenColor,
                                    )
                                  : const Icon(
                                      Icons.arrow_drop_down,
                                      size: 18,
                                      color: kRedColor,
                                    ),
                              Text(
                                '\$${NumberFormat().format(data.nftUsdt)}',
                                style: TextStyle(
                                    color: nftWorthCheck(data)
                                        ? kRedColor
                                        : kGreenColor),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                Chart2(
                  chain: data.chain ?? 'SOL',
                  total: data.totalBase!.toDouble(),
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        });
  }

  bool nftWorthCheck(SolWalletData data) {
    return data.nftList?.isEmpty ?? true
        ? false
        : List.generate(data.nftList?.length ?? 0,
                    (index) => data.nftList?[index].percentChange ?? 0)
                .reduce((a, b) => a + b) <
            0;
  }
}

class Chart2 extends StatefulWidget {
  const Chart2({
    Key? key,
    required this.chain,
    required this.total,
  }) : super(key: key);
  final String chain;
  final double total;

  @override
  State<Chart2> createState() => _Chart2State();
}

class _Chart2State extends State<Chart2>
    with AutomaticKeepAliveClientMixin<Chart2> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List>(
        future: refPrice(chain: widget.chain, totalWorth: widget.total),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Column(
              children: [
                SizedBox(
                    height: 110,
                    child: LineChart(LineChartData(
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(show: false),
                        gridData: FlGridData(show: false),
                        lineTouchData: LineTouchData(
                            touchTooltipData: LineTouchTooltipData(
                          fitInsideHorizontally: true,
                          tooltipBgColor: Colors.black,
                          tooltipMargin: 25,
                          getTooltipItems: (touchedSpots) {
                            return List.generate(
                                touchedSpots.length,
                                (index) => LineTooltipItem(
                                    '\$${touchedSpots[index].y.toStringAsFixed(2)}',
                                    const TextStyle(fontSize: 12)));
                          },
                        )),
                        lineBarsData: [
                          LineChartBarData(
                            color: Colors.lightBlueAccent,
                            belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.blue.withOpacity(.56),
                                      Colors.transparent,
                                    ])),
                            dotData: FlDotData(
                              show: false,
                            ),
                            spots: List.generate(
                                data!.length,
                                (index) => FlSpot(index.toDouble(),
                                    data[index].last.toDouble())),
                            shadow: const Shadow(
                                blurRadius: 500, color: kGreenColor),
                            isCurved: true,
                            preventCurveOverShooting: true,
                          )
                        ]))),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      buttons.length,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: TextButton(
                                onPressed: () {
                                  // setState(() {
                                  //   buttons.updateAll((key, value) => false);
                                  //   buttons.update(
                                  //       buttons.keys.elementAt(index),
                                  //       (value) => true);
                                  //   setState(() {
                                  //     length = index + 1;
                                  //   });
                                  // });
                                  // pageController.jumpToPage(
                                  //   index,
                                  // );
                                  dialog(context);
                                },
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          color: buttons.values.elementAt(index)
                                              ? Colors.white
                                              : Colors.transparent,
                                          width: 1)),
                                ),
                                child: Text(
                                  buttons.keys.elementAt(index),
                                  style: TextStyle(
                                      color: buttons.values.elementAt(index)
                                          ? Colors.white
                                          : kGreyColor),
                                )),
                          )),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          } else {
            return const SizedBox();
          }
        });
  }

  @override
  bool get wantKeepAlive => true;
}

class NetWorthChart extends StatelessWidget {
  final double totalSol;
  final String chain;
  final bool isRed;
  const NetWorthChart({
    Key? key,
    required this.totalSol,
    required this.chain,
    required this.isRed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);

    return FutureBuilder<List>(
        future: refPrice(totalWorth: totalSol, chain: chain),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(
                  height: 100,
                  child: PageView.builder(
                      itemCount: buttons.length,
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Sparkline(
                            useCubicSmoothing: true,
                            lineColor: Colors.lightBlueAccent,
                            fillMode: FillMode.below,
                            fillGradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.lightBlueAccent.withOpacity(.8),
                                  Colors.transparent
                                ]),
                            lineWidth: 1.5,
                            data: List.generate(
                                snapshot.data!.length,
                                (index) =>
                                    snapshot.data![index].last.toDouble()));
                      }),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      buttons.length,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: TextButton(
                                onPressed: () {
                                  // setState(() {
                                  //   buttons.updateAll((key, value) => false);
                                  //   buttons.update(
                                  //       buttons.keys.elementAt(index),
                                  //       (value) => true);
                                  //   setState(() {
                                  //     length = index + 1;
                                  //   });
                                  // });
                                  // pageController.jumpToPage(
                                  //   index,
                                  // );
                                  dialog(context);
                                },
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          color: buttons.values.elementAt(index)
                                              ? Colors.white
                                              : Colors.transparent,
                                          width: 1)),
                                ),
                                child: Text(
                                  buttons.keys.elementAt(index),
                                  style: TextStyle(
                                      color: buttons.values.elementAt(index)
                                          ? Colors.white
                                          : kGreyColor),
                                )),
                          )),
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
