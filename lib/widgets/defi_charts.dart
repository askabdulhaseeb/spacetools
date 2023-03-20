import 'dart:ui';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import '../Model/sol_top_movers.dart';
import 'custom_widget/app_bar.dart';
import 'custom_widget/custom_sliding_text.dart';
import 'net_worth.dart';
import '../Model/coins.dart';
import '../Model/solana_data.dart';
import '../constants.dart';
import '../pages/nft.dart';
import 'live_list.dart';
import 'trending.dart';

class DefiCharts extends StatelessWidget {
  const DefiCharts({
    Key? key,
    required this.coinFuture,
    required this.solanaFuture,
    required this.solTopMoversFuture,
    required this.onRefresh,
    required this.address,
    required this.onTap,
    required this.isTapped,
    required this.isEth,
  }) : super(key: key);
  final Future<Coins> coinFuture;
  final Future<SolanaData> solanaFuture;
  final Future<List<SolTopMovers>> solTopMoversFuture;
  final Future<void> Function() onRefresh;
  final String address;
  final VoidCallback onTap;
  final ValueNotifier<bool> isTapped;
  final bool isEth;

  @override
  Widget build(BuildContext context) {
    final controller = FixedExtentScrollController(initialItem: 1);
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: Colors.white,
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
              height: 120,
              child: buildAppBar(
                context,
                [],
                isTabbarNeeded: false,
                address: address,
                isTapped: isTapped,
                onTap: onTap,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomSlidingText(
                  color: Colors.lightBlueAccent,
                  boxColor: Colors.lightBlueAccent,
                  radius: 20,
                ),
                FutureBuilder<Coins>(
                    future: coinFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data?.data;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isEth ? 'Ethereum Price' : 'Solana Price',
                              style: textTheme(context).labelMedium,
                            ),
                            Row(
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text:
                                          '\$${data![isEth ? 0 : 1].usdPrice.toInt()}',
                                      style: const TextStyle(
                                          fontSize: 48, color: Colors.white)),
                                  TextSpan(
                                      text: data[isEth ? 0 : 1]
                                          .usdPrice
                                          .toStringAsFixed(2)
                                          .substring(data[isEth ? 0 : 1]
                                              .usdPrice
                                              .toStringAsFixed(2)
                                              .indexOf('.')),
                                      style: TextStyle(
                                          fontSize: 48,
                                          color: kGreyColor.withOpacity(.25)))
                                ])),
                                const SizedBox(
                                  width: 10,
                                ),
                                Label(
                                  text:
                                      '${(((data[isEth ? 0 : 1].usdPriceChange24H) * 100).toStringAsFixed(2).substring((data[isEth ? 0 : 1].usdPriceChange24H) * 100 >= 0 ? 0 : 1))}%',
                                  icon: checkCoinIcon(
                                      (data[isEth ? 0 : 1].usdPriceChange24H *
                                              100)
                                          .toStringAsFixed(2)),
                                  color: checkCoinColor(
                                      (data[isEth ? 0 : 1].usdPriceChange24H *
                                              100)
                                          .toStringAsFixed(2)),
                                  boxColor: checkCoinColor(
                                      (data[isEth ? 0 : 1].usdPriceChange24H *
                                              100)
                                          .toStringAsFixed(2)),
                                  opacity: .1,
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                FutureBuilder<SolanaData>(
                    future: solanaFuture,
                    builder: (context, snapshot) {
                      final data = snapshot.data?.data;
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 10, 5, 10),
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Market Cap',
                                                style: textTheme(context)
                                                    .labelMedium,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '\$${formatNumber(data!.marketCap)}',
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    '${data.marketCapChangeRate > 0 ? '+' : ''}${(data.marketCapChangeRate * 100).toStringAsFixed(2)}%',
                                                    style: TextStyle(
                                                        color: checkCoinColor(
                                                            (data.marketCapChangeRate *
                                                                    100)
                                                                .toStringAsFixed(
                                                                    2))),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            height: 40,
                                            child: Sparkline(
                                                useCubicSmoothing: true,
                                                lineWidth: 2,
                                                fillGradient: LinearGradient(
                                                    colors: [
                                                      checkCoinColor(
                                                              (data.marketCapChangeRate *
                                                                      100)
                                                                  .toStringAsFixed(
                                                                      2))
                                                          .withOpacity(.2),
                                                      Colors.transparent
                                                    ],
                                                    begin:
                                                        const Alignment(0, .7),
                                                    end: const Alignment(0, 3)),
                                                fillMode: FillMode.below,
                                                lineColor: checkCoinColor(
                                                    (data.marketCapChangeRate *
                                                            100)
                                                        .toStringAsFixed(2)),
                                                data: List.generate(
                                                    data.samples.length ~/ 4,
                                                    (index) => data
                                                        .samples[index]
                                                        .marketCap))),
                                        Positioned(
                                          bottom: 10,
                                          child: ImageFiltered(
                                            imageFilter: ImageFilter.blur(
                                                sigmaX: 25, sigmaY: 25),
                                            child: CircleAvatar(
                                              backgroundColor: checkCoinColor(
                                                      (data.marketCapChangeRate *
                                                              100)
                                                          .toStringAsFixed(2))
                                                  .withOpacity(.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(5, 10, 0, 10),
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Volume',
                                                style: textTheme(context)
                                                    .labelMedium,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '\$${formatNumber(data.tradeVolume)}',
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    '${data.tradeVolumeChangeRate > 0 ? '+' : ''}${(data.tradeVolumeChangeRate * 100).toStringAsFixed(2)}%',
                                                    style: TextStyle(
                                                        color: checkCoinColor(
                                                            (data.tradeVolumeChangeRate *
                                                                    100)
                                                                .toStringAsFixed(
                                                                    2))),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          child: Sparkline(
                                              useCubicSmoothing: true,
                                              lineWidth: 2,
                                              fillGradient: LinearGradient(
                                                  colors: [
                                                    checkCoinColor(
                                                            (data.tradeVolumeChangeRate *
                                                                    100)
                                                                .toStringAsFixed(
                                                                    2))
                                                        .withOpacity(.2),
                                                    Colors.transparent
                                                  ],
                                                  begin: const Alignment(0, .7),
                                                  end: const Alignment(0, 3)),
                                              fillMode: FillMode.below,
                                              lineColor: checkCoinColor(
                                                  (data.tradeVolumeChangeRate *
                                                          100)
                                                      .toStringAsFixed(2)),
                                              data: List.generate(
                                                  data.samples.length ~/ 4,
                                                  (index) => data.samples[index]
                                                      .tradeVolume)),
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          child: ImageFiltered(
                                            imageFilter: ImageFilter.blur(
                                                sigmaX: 25, sigmaY: 25),
                                            child: CircleAvatar(
                                              backgroundColor: checkCoinColor(
                                                      (data.tradeVolumeChangeRate *
                                                              100)
                                                          .toStringAsFixed(2))
                                                  .withOpacity(.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // Text(
                            //   isEth
                            //       ? 'Ethereum to USD Chart'
                            //       : 'Solana to USD Chart',
                            //   style: textTheme(context).bodyLarge,
                            // ),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            // Chart2(
                            //   chain: isEth ? 'ETH' : 'SOL',
                            //   total: 1,
                            // )
                            // NetWorthChart(
                            //   chain: 'SOL',
                            //   totalSol: 1,
                            //   isRed: (data.marketCapChangeRate * 100) > 0,
                            // ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 208,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25)),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        left: -400,
                        child: Container(
                          width: 200,
                          decoration: const BoxDecoration(
                              gradient: RadialGradient(colors: [
                            Color(0xFF00415C),
                            Colors.transparent
                          ])),
                        ),
                      ),
                      Positioned.fill(
                        right: -400,
                        child: Container(
                          width: 200,
                          decoration: const BoxDecoration(
                              gradient: RadialGradient(colors: [
                            Color(0xFF004625),
                            Colors.transparent
                          ])),
                        ),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'From Degen to Datalord 🔥',
                                style: textTheme(context).bodyLarge,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Conquer DeFi and innovate your wealth',
                                style: textTheme(context).labelMedium,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    2,
                                    (index) => GestureDetector(
                                          onTap: () => dialog(context),
                                          child: Container(
                                            width: 151.5,
                                            height: 44,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(111),
                                                color: index == 0
                                                    ? Colors.blue
                                                    : kGreenColor),
                                            child: Center(
                                                child: Text(index == 0
                                                    ? 'Innovate'
                                                    : 'Invest')),
                                          ),
                                        )),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'What is a flash Loan?',
                                    style: textTheme(context).labelMedium,
                                  ),
                                  GestureDetector(
                                    onTap: () => dialog(context),
                                    child: const Icon(
                                      Icons.info_outline,
                                      size: 18,
                                      color: Colors.blue,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Top Movers',
                      style: textTheme(context).bodyLarge,
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.info_outline,
                      size: 18,
                      color: Colors.blue,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                FutureBuilder<List<SolTopMovers>>(
                    future: solTopMoversFuture,
                    builder: (context, snapshot) {
                      final data = snapshot.data;
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: 150,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: data!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => dialog(context),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          width: 125,
                                          height: 130,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(.7),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 42, left: 3, right: 3),
                                            child: Column(
                                              children: [
                                                Text(
                                                  data[index].name,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  data[index].symbol,
                                                  style: const TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 12.5),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  '\$${data[index].usdPrice.toStringAsFixed(6)}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  height: 1.5,
                                                ),
                                                Text(
                                                  '${data[index].usdPriceChange24H * 100 > 0 ? '+' : ''}${(data[index].usdPriceChange24H * 100).toStringAsFixed(2)}%',
                                                  style: TextStyle(
                                                      fontSize: 12.5,
                                                      color: checkCoinColor((data[
                                                                      index]
                                                                  .usdPriceChange24H *
                                                              100)
                                                          .toStringAsFixed(2))),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      child: CircleAvatar(
                                        backgroundColor: kLighterColor,
                                        backgroundImage: NetworkImage(
                                            'https://crypto.com/price/_next/image?url=https://static.crypto.com/token/icons/${data[index].slug}/color_icon.png&w=128&q=75'),
                                        radius: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                FutureBuilder<Coins>(
                    future: coinFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return AspectRatio(
                          aspectRatio:
                              MediaQuery.of(context).size.height / 8400,
                          child: ChartListView(
                            coinsData: snapshot.data,
                            isTrending: false,
                            title: isEth
                                ? 'Ethereum Coin Prices'
                                : 'Solana Coin Prices',
                            controller: controller,
                            scrollPhysics: const NeverScrollableScrollPhysics(),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
