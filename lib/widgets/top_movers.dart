import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spacetools/Model/eth_trending_top.dart';
import '../Model/top_movers.dart';
import '../constants.dart';

class TopMovers extends StatelessWidget {
  const TopMovers({
    Key? key,
    required this.isVisible,
    required this.future,
    required this.isEth,
    required this.ethFuture,
  }) : super(key: key);
  final ValueListenable<bool> isVisible;
  final bool isEth;
  final Future<TopMoversData> future;
  final Future<List<EthTrendingTop>> ethFuture;

  @override
  Widget build(BuildContext context) {
    if (isEth) {
      return FutureBuilder<List<EthTrendingTop>>(
        future: ethFuture,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.hasData) {
            return TopMoversWidget(
              isVisible: isVisible,
              ethData: data,
              isEth: true,
            );
          } else {
            return const SizedBox();
          }
        },
      );
    } else {
      return FutureBuilder<TopMoversData>(
        future: future,
        builder: (context, snapshot) {
          final data = snapshot.data?.nfts;
          if (snapshot.hasData) {
            return TopMoversWidget(
              isVisible: isVisible,
              data: data,
              isEth: false,
            );
          } else {
            return const SizedBox();
          }
        },
      );
    }
  }
}

class TopMoversWidget extends StatelessWidget {
  const TopMoversWidget({
    Key? key,
    required this.isVisible,
    this.data,
    required this.isEth,
    this.ethData,
  }) : super(key: key);

  final ValueListenable<bool> isVisible;
  final bool isEth;
  final List<Nft>? data;
  final List<EthTrendingTop>? ethData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Top Movers',
            style: textTheme(context).bodyLarge,
          ),
        ),
        ValueListenableBuilder(
            valueListenable: isVisible,
            builder: (context, bool value, child) {
              return AnimatedContainer(
                height: value ? 205 : 80,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
                child: ListView.builder(
                  //cacheExtent: 9999,
                  shrinkWrap: true,
                  itemCount: isEth ? ethData!.length : data!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => dialog(context),
                      child: Container(
                        margin: const EdgeInsets.all(6),
                        width: 134,
                        decoration: BoxDecoration(
                          color: kLighterColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: value,
                              child: Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1.1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white12,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          onError: (exception, stackTrace) {},
                                          image: NetworkImage(isEth
                                              ? ethData![index].image ?? ''
                                              : data![index].sampleImageUrl ??
                                                  ''),
                                        ),
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isEth
                                        ? ethData![index].name ?? ''
                                        : data![index].name ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        isEth
                                            ? 'assets/Ethereum-Logo-PNG-HD-Image.png'
                                            : 'assets/Solana.png',
                                        scale: 3,
                                        height: isEth ? 16 : null,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        isEth
                                            ? double.parse(
                                                    ethData![index].floor ??
                                                        '0.00%')
                                                .toStringAsFixed(2)
                                            : data![index]
                                                .floorPrice!
                                                .toDouble()
                                                .toStringAsFixed(2),
                                      ),
                                      const Spacer(),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          isEth
                                              ? 'Vol \$${formatNumber(ethData![index].volume?.toDouble() ?? 0)}'
                                              : data![index].volume != null
                                                  ? 'Vol \$${formatNumber((data![index].volume ?? 0).toDouble())}'
                                                  : 'Vol --',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey.shade400),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
      ],
    );
  }
}
