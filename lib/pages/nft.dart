import 'dart:async';
import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:spacetools/widgets/custom_widget/custom_sliding_text.dart';
import '../Model/eth_trending_top.dart';
import '../widgets/custom_widget/app_bar.dart';
import '../Model/biggest_whale_top_traders.dart';
import '../Model/calendar.dart';
import '../Model/recent_activity.dart';
import '../widgets/mint.dart';
import '../widgets/recent_activity.dart';
import '../widgets/social.dart';
import '../Model/trending.dart';
import '../Services/service.dart';
import '../Model/top_movers.dart';
import '../widgets/live_list.dart';
import '../widgets/top_movers.dart';
import '../widgets/trending.dart';

class NFTPage extends StatefulWidget {
  final String address;
  const NFTPage({Key? key, required this.address}) : super(key: key);

  @override
  State<NFTPage> createState() => _NFTPageState();
}

class _NFTPageState extends State<NFTPage>
    with AutomaticKeepAliveClientMixin<NFTPage> {
  late ScrollController scrollController;
  late ScrollController ethScrollController;
  final ValueNotifier<bool> visible = ValueNotifier<bool>(true);
  late Future<TopMoversData> topMoversFuture;
  late Future<List<EthTrendingTop>> ethTopMoversFuture;
  late Future<List<TrendingData>> trendingFuture;
  late Future<List<EthTrendingTop>> ethTrendingFuture;
  late Future<RecentActivityData> recentActivityStream;
  late Future<BiggestWhalesAndTopTraders> biggestWhalesFuture;
  late Future<BiggestWhalesAndTopTraders> topTradersFuture;
  late Future<List<Calendar>> mintFuture;
  late Future<List<Calendar>> ethMintFuture;
  Timer? timer;
  @override
  void initState() {
    topMoversFuture = topMoversData();
    ethTopMoversFuture = ethTopMoversData();
    trendingFuture = tenMinTrendingData();
    ethTrendingFuture = ethTrendingData();
    // ethTrendingFuture = tenMinTrendingData();
    recentActivityStream = recentActivityData();
    biggestWhalesFuture = biggestWhalesData();
    topTradersFuture = topTradersData();
    mintFuture = calendarData();
    ethMintFuture = ethCalendarData();
    scrollController = ScrollController();
    ethScrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        visible.value = false;
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        visible.value = true;
      }
    });
    ethScrollController.addListener(() {
      if (ethScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        visible.value = false;
      }
      if (ethScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        visible.value = true;
      }
    });
    super.initState();
  }

  //bool isTapped = true;
  final ValueNotifier<bool> isTapped = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ValueListenableBuilder<bool>(
        valueListenable: isTapped,
        builder: (context, isSol, child) {
          final PageController pageController =
              PageController(initialPage: isSol ? 0 : 1);
          final PageController mintPageController =
              PageController(initialPage: isSol ? 0 : 1);
          final PageController socialPageController =
              PageController(initialPage: isSol ? 0 : 1);
          return DefaultTabController(
            length: 4,
            child: Builder(builder: (ctx) {
              return Scaffold(
                appBar: buildAppBar(
                  context,
                  ['Charts', 'Social', 'Live', 'Mint'],
                  address: widget.address,
                  isTapped: isTapped,
                  onTap: () {
                    isTapped.value = !isTapped.value;
                    if (pageController.hasClients) {
                      if (isTapped.value) {
                        pageController.jumpToPage(0);
                      } else {
                        pageController.jumpToPage(1);
                      }
                    }
                    if (mintPageController.hasClients) {
                      if (isTapped.value) {
                        mintPageController.jumpToPage(0);
                      } else {
                        mintPageController.jumpToPage(1);
                      }
                    }
                    if (socialPageController.hasClients) {
                      if (isTapped.value) {
                        socialPageController.jumpToPage(0);
                      } else {
                        socialPageController.jumpToPage(1);
                      }
                    }
                  },
                ),
                body: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: CustomSlidingText(
                        color: Colors.lightBlueAccent,
                        boxColor: Colors.lightBlueAccent,
                        radius: 20,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        PageView(
                          controller: pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            FadeIn(
                              child: Column(
                                children: [
                                  TopMovers(
                                    isVisible: visible,
                                    future: topMoversFuture,
                                    ethFuture: ethTopMoversFuture,
                                    isEth: false,
                                  ),
                                  Expanded(
                                    child: Trending(
                                      scrollController: scrollController,
                                      future: trendingFuture,
                                      isEth: false,
                                      ethFuture: ethTrendingFuture,
                                      ethScrollController: ethScrollController,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            FadeIn(
                              child: Column(
                                children: [
                                  TopMovers(
                                    isVisible: visible,
                                    future: topMoversFuture,
                                    ethFuture: ethTopMoversFuture,
                                    isEth: true,
                                  ),
                                  Expanded(
                                    child: Trending(
                                      scrollController: scrollController,
                                      future: trendingFuture,
                                      isEth: true,
                                      ethFuture: ethTrendingFuture,
                                      ethScrollController: ethScrollController,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        PageView(
                          controller: socialPageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Social(
                                    title: 'Biggest Whales',
                                    future: biggestWhalesFuture,
                                    isEth: false,
                                  ),
                                  Social(
                                    title: 'Top Traders',
                                    future: topTradersFuture,
                                    isEth: false,
                                  ),
                                  Expanded(
                                    child: SocialTab(
                                      stream: recentActivityStream,
                                      isEth: false,
                                    ),
                                  )
                                ]),
                            Stack(
                              children: [
                                ImageFiltered(
                                  imageFilter:
                                      ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Social(
                                          title: 'Biggest Whales',
                                          future: biggestWhalesFuture,
                                          isEth: true,
                                        ),
                                        Social(
                                          title: 'Top Traders',
                                          future: topTradersFuture,
                                          isEth: true,
                                        ),
                                        Expanded(
                                          child: SocialTab(
                                            stream: recentActivityStream,
                                            isEth: true,
                                          ),
                                        )
                                      ]),
                                ),
                                const LockedFeature()
                              ],
                            ),
                          ],
                        ),
                        const LiveListView(),
                        PageView(
                          controller: mintPageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            FadeIn(
                                child: Mint(
                                    future: mintFuture,
                                    ethFuture: ethMintFuture,
                                    isEth: false)),
                            FadeIn(
                                child: Mint(
                                    future: mintFuture,
                                    ethFuture: ethMintFuture,
                                    isEth: true))
                          ],
                        )
                      ]),
                    ),
                  ],
                ),
              );
            }),
          );
        });
  }

  @override
  void dispose() {
    visible.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
