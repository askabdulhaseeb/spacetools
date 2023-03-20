import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spacetools/Model/eth_trending_top.dart';
import 'package:spacetools/widgets/custom_widget/loading_widget.dart';
import '../Model/chart_data.dart';
import '../Model/coins.dart';
import '../Model/trending.dart';
import '../constants.dart';
import './chart_widget.dart';

final Map<String, bool> labels = {'1H': false, '1W': true, '1D': false};

class Trending extends StatefulWidget {
  const Trending({
    Key? key,
    required this.scrollController,
    required this.future,
    required this.ethFuture,
    required this.isEth,
    required this.ethScrollController,
  }) : super(key: key);
  final ScrollController scrollController;
  final ScrollController ethScrollController;
  final Future<List<TrendingData>> future;
  final Future<List<EthTrendingTop>> ethFuture;
  final bool isEth;
  static bool isPremium = false;

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  final PageController pageController = PageController(initialPage: 1);
  late Future<ChartData> chartFuture;
  final FixedExtentScrollController controller =
      FixedExtentScrollController(initialItem: 1);

  @override
  Widget build(BuildContext context) {
    if (widget.isEth) {
      return FutureBuilder<List<EthTrendingTop>>(
        future: widget.ethFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChartListView(
              controller: controller,
              isEth: true,
              eth: snapshot.data,
              widget: widget,
            );
          } else {
            return snapshot.hasError
                ? const Text(
                    'Facing some issue, while loading',
                    style: TextStyle(color: Colors.grey),
                  )
                : const LoadingWidget();
          }
        },
      );
    } else {
      return FutureBuilder<List<TrendingData>>(
        future: widget.future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChartListView(
              controller: controller,
              isEth: false,
              trendingData: snapshot.data,
              widget: widget,
            );
          } else {
            return snapshot.hasError
                ? const Text(
                    'Facing some issue, while loading',
                    style: TextStyle(color: Colors.grey),
                  )
                : const LoadingWidget();
          }
        },
      );
    }
  }
}

class ChartListView extends StatelessWidget {
  const ChartListView({
    Key? key,
    required this.controller,
    this.trendingData,
    this.widget,
    this.isTrending = true,
    this.title = 'Trending',
    this.coinsData,
    this.scrollPhysics,
    this.isEth = false,
    this.eth,
  }) : super(key: key);

  final FixedExtentScrollController controller;
  final List<TrendingData>? trendingData;
  final Coins? coinsData;
  final Trending? widget;
  final bool isTrending;
  final String title;
  final ScrollPhysics? scrollPhysics;
  final bool isEth;
  final List<EthTrendingTop>? eth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            style: textTheme(context).bodyLarge,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            height: 36,
            child: ElevatedButton(
              onPressed: () {
                dialog(context);
              },
              child: Text(
                'My Watchlist',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => dialog(context),
            child: Container(
              height: 36,
              width: 120,
              decoration: BoxDecoration(
                  color: kLighterColor,
                  borderRadius: BorderRadius.circular(10)),
              child: SizedBox(
                height: 20,
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    const Icon(Icons.access_time, size: 20),
                    Expanded(
                      child: RotatedBox(
                        quarterTurns: -1,
                        child: ListWheelScrollView(
                            physics: const FixedExtentScrollPhysics(),
                            controller: controller,
                            diameterRatio: 1.6,
                            useMagnifier: true,
                            onSelectedItemChanged: (index) {
                              if (Trending.isPremium) {
                                // setState(
                                //   () {
                                //     labels.updateAll(
                                //         (key, value) => false);
                                //     labels.update(
                                //         labels.keys.elementAt(index),
                                //         (value) => true);
                                //   },
                                // );
                                // pageController.animateToPage(index,
                                //     duration: const Duration(
                                //         milliseconds: 1200),
                                //     curve: Curves.ease);
                              } else {
                                controller.animateToItem(1,
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    curve: Curves.ease);
                                index != 1 ? dialog(context) : null;
                              }
                            },
                            itemExtent: 25,
                            children: List.generate(
                                3,
                                (index) => SizedBox(
                                      width: 25,
                                      child: RotatedBox(
                                        quarterTurns: 1,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              backgroundColor:
                                                  Colors.transparent),
                                          onPressed: () {},
                                          child: Text(
                                            labels.keys.elementAt(index),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: labels.values
                                                        .elementAt(index)
                                                    ? Colors.white
                                                    : kGreyColor
                                                        .withOpacity(.7)),
                                          ),
                                        ),
                                      ),
                                    ))),
                      ),
                    ),
                    const SizedBox(width: 5)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 36,
            child: ElevatedButton(
              onPressed: () {
                dialog(context);
              },
              child: SvgPicture.asset('assets/sliders.svg'),
            ),
          ),
          InkWell(
            onTap: () => dialog(context),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset('assets/search.svg'),
            ),
          )
        ]),
        const SizedBox(height: 10),
        Expanded(
            child: ListView.builder(
          //cacheExtent: 9999,
          physics: scrollPhysics,
          itemCount: isEth
              ? eth!.length
              : isTrending
                  ? trendingData?.length ?? 0
                  : coinsData?.data.length ?? 0,
          shrinkWrap: true,
          controller: isEth
              ? widget?.ethScrollController
              : widget?.scrollController ?? ScrollController(),
          itemBuilder: (context, index) {
            return Stack(
              children: [
                ListTile(
                  onTap: () => dialog(context),
                  horizontalTitleGap: 10,
                  title: Text(
                    isEth
                        ? eth![index].name ?? ''
                        : isTrending
                            ? trendingData![index].name.contains(',')
                                ? trendingData![index].name.substring(0,
                                    trendingData![index].name.indexOf(',') - 1)
                                : trendingData![index].name
                            : coinsData!.data[index].name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        isEth
                            ? 'ETH'
                            : isTrending
                                ? 'SOL'
                                : 'USDT',
                        style: const TextStyle(color: kGreyColor, fontSize: 12),
                      ),
                      SizedBox(width: isTrending || isEth ? 10 : 6),
                      isEth
                          ? const SizedBox()
                          : isTrending
                              ? SizedBox(
                                  width: 45,
                                  height: 15,
                                  child: Chart(
                                    data: trendingData,
                                    index: index,
                                  ))
                              : SizedBox(
                                  width: 45,
                                  height: 15,
                                  child: Sparkline(
                                    data: coinsData!.data[index].prices.sublist(
                                      coinsData!.data[index].prices.length ~/ 3,
                                    ),
                                    lineWidth: 2,
                                    useCubicSmoothing: true,
                                    lineColor: checkCoinColor((coinsData!
                                                .data[index].usdPriceChange24H *
                                            100)
                                        .toStringAsFixed(2)),
                                    fillGradient: LinearGradient(
                                        colors: [
                                          checkCoinColor((coinsData!.data[index]
                                                          .usdPriceChange24H *
                                                      100)
                                                  .toStringAsFixed(2))
                                              .withOpacity(.3),
                                          Colors.transparent
                                        ],
                                        begin: const Alignment(0, .7),
                                        end: const Alignment(0, 3)),
                                    fillMode: FillMode.below,
                                  ),
                                ),
                      const SizedBox(width: 5),
                      isEth
                          ? ethNFTIconCheck(eth![index].floorChangeColor!)
                          : isTrending
                              ? iconCheck(trendingData![index].color ??
                                  ColorValues.gray)
                              : checkCoinIcon(
                                  (coinsData!.data[index].usdPriceChange24H *
                                          100)
                                      .toStringAsFixed(2)),
                      Expanded(
                          child: Text(
                        isEth
                            ? eth![index].floorChange ?? '0.00%'
                            : isTrending
                                ? trendingData![index].tenMinFloor
                                : coinsData!.data[index].usdPriceChange24H *
                                            100 >
                                        0
                                    ? '${(coinsData!.data[index].usdPriceChange24H * 100).toStringAsFixed(2)}%'
                                    : '${(coinsData!.data[index].usdPriceChange24H * 100).toStringAsFixed(2).substring(1)}%',
                        style: TextStyle(
                          color: isEth
                              ? ethCheckColor(eth![index].floorChangeColor!)
                                  .first
                              : isTrending
                                  ? checkColor(trendingData![index].color ??
                                          ColorValues.gray)
                                      .first
                                  : checkCoinColor((coinsData!
                                              .data[index].usdPriceChange24H *
                                          100)
                                      .toStringAsFixed(2)),
                        ),
                      )),
                    ],
                  ),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            onError: (exception, stackTrace) {
                              debugPrint('error');
                            },
                            fit: BoxFit.cover,
                            image: NetworkImage(isEth
                                ? eth![index].image ?? ''
                                : isTrending
                                    ? trendingData![index].image
                                    : 'https://crypto.com/price/_next/image?url=https://static.crypto.com/token/icons/${coinsData!.data[index].slug}/color_icon.png&w=128&q=75')),
                        color:
                            isTrending || isEth ? kLighterColor : Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  trailing: SizedBox(
                    width: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Spacer(),
                        Row(
                          children: [
                            const Spacer(),
                            isEth
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: Image.asset(
                                      'assets/Ethereum-Logo-PNG-HD-Image.png',
                                      height: 18,
                                    ),
                                  )
                                : isTrending
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4),
                                        child: Image.asset(
                                          'assets/Solana.png',
                                          scale: 3,
                                        ),
                                      )
                                    : const SizedBox(),
                            isEth
                                ? Text(eth![index].floor ?? '0.00')
                                : isTrending
                                    ? Text(trendingData![index]
                                                .floor
                                                .contains(',') ||
                                            trendingData![index]
                                                .floor
                                                .contains('--')
                                        ? '${trendingData![index].floor}.00'
                                        : double.parse(
                                                trendingData![index].floor)
                                            .toStringAsFixed(2))
                                    : Text(
                                        '\$${coinsData!.data[index].usdPrice.toStringAsFixed(2)}',
                                      ),
                            SizedBox(width: isTrending || isEth ? 0 : 53)
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Spacer(),
                            Text(
                              isEth ? 'MarketCap:' : 'Volume: ',
                              style: const TextStyle(
                                  fontSize: 12, color: kGreyColor),
                            ),
                            Text(
                              '\$${formatNumber(isEth ? eth![index].mcap!.toDouble() : isTrending ? trendingData![index].mcap.toDouble() : coinsData!.data[index].usdMarketcap)}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                ),
                isTrending || isEth
                    ? const SizedBox()
                    : Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 29,
                          margin: const EdgeInsets.only(top: 9, right: 5),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: Colors.blue),
                              onPressed: () => dialog(context),
                              child: const Text('Trade')),
                        ),
                      )
              ],
            );
          },
        )),
      ],
    );
  }
}
