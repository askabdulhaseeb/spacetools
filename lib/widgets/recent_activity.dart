import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../widgets/live_list.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../Model/recent_activity.dart';

class SocialTab extends StatelessWidget {
  const SocialTab({
    Key? key,
    required this.stream,
    required this.isEth,
  }) : super(key: key);
  final Future<RecentActivityData> stream;
  final bool isEth;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream.asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return RecentActivity(
            solData: snapshot.data,
            isEth: isEth,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class RecentActivity extends StatefulWidget {
  const RecentActivity({
    Key? key,
    this.solData,
    required this.isEth,
  }) : super(key: key);
  final RecentActivityData? solData;
  final bool isEth;

  @override
  State<RecentActivity> createState() => _RecentActivityState();
}

class _RecentActivityState extends State<RecentActivity> {
  double value = 0;
  increaseValue() async {
    while (true) {
      for (var i = 0; i < 16; i++) {
        await Future.delayed(
          const Duration(seconds: 1),
          () {
            if (mounted) {
              setState(() {
                value += 0.066666666;
              });
            }
          },
        );
      }
    }
  }

  late Timer timer;
  @override
  void initState() {
    if (!widget.isEth) {
      increaseValue();
      timer = Timer.periodic(
        const Duration(seconds: 15),
        (timer) {
          if (mounted) {
            value = 0;
            setState(() {});
          }
        },
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  double checkPrice(RecentActivityData data, int index) {
    late final double price;
    if (data.socialActivities[index].lastTransactionPriceSol != null) {
      price = data.socialActivities[index].lastTransactionPriceSol!;
    } else if (data.socialActivities[index].listing?.listing?.priceSol !=
        null) {
      price = data.socialActivities[index].listing!.listing!.priceSol!;
    } else {
      price = double.parse(data.socialActivities[index].transaction!.price!);
    }
    return price;
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.solData?.socialActivities;
    return FadeIn(
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Activity',
                  style: textTheme(context).bodyLarge,
                ),
                const Spacer(),
                LinearPercentIndicator(
                    percent: value,
                    animation: true,
                    lineHeight: 5.5,
                    animationDuration: 900,
                    width: 75,
                    animateFromLastPercent: true,
                    barRadius: const Radius.circular(5),
                    curve: Curves.ease,
                    backgroundColor: kLighterColor,
                    linearGradient: const LinearGradient(
                      colors: [Color(0xFF254BFF), Color(0xFFD756C5)],
                      end: Alignment(2, 4),
                    )),
                const Spacer(
                  flex: 15,
                ),
                GestureDetector(
                  onTap: () => dialog(context),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SvgPicture.asset('assets/search.svg'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Twitter handle',
                        style: textTheme(context).labelMedium,
                      ),
                      Text(
                        'Transaction',
                        style: textTheme(context).labelMedium,
                      ),
                      Text(
                        'Date',
                        style: textTheme(context).labelMedium,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: widget.isEth
                        ? const NeverScrollableScrollPhysics()
                        : null,
                    itemCount: data!.length,
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: kGreyColor.withOpacity(.3),
                        height: 5,
                        thickness: 1,
                      );
                    },
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => dialog(context),
                        contentPadding: EdgeInsets.zero,
                        horizontalTitleGap: 7,
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: kGreyColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: widget.isEth
                                ? const SizedBox()
                                : (data[index].profileImageUrl != null ||
                                        data[index]
                                                .transaction
                                                ?.primaryActor
                                                ?.twitterImage !=
                                            null)
                                    ? Image.network(
                                        data[index].profileImageUrl ??
                                            data[index]
                                                .transaction!
                                                .primaryActor!
                                                .twitterImage!,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.black,
                                            child: const Center(
                                              child: Text(
                                                'Error Loading Image',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Container(
                                        color: Colors.black,
                                        child: const Center(
                                          child: Text(
                                            'Error Loading Image',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                          ),
                        ),
                        title: Text(
                          '@${data[index].actor!.twitterHandle!}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Row(
                          children: [
                            const Text(
                              'Net Worth',
                              style: TextStyle(fontSize: 13),
                            ),
                            Text(
                              '\$${formatNumber(data[index].nftPortfolioValueUsd ?? 0.toDouble())}',
                              style: textTheme(context).bodyMedium,
                            )
                          ],
                        ),
                        trailing: SizedBox(
                          width: 180,
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 110,
                                    child: Text(
                                      data[index].collectionName ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Label(
                                        text: checkType(widget.solData!, index),
                                        color: checkTypeColor(
                                            widget.solData!, index,
                                            purpleColor: kPurpleColor),
                                        boxColor: checkTypeColor(
                                            widget.solData!, index,
                                            purpleColor: kPurpleColor2),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      const Text(
                                        'for',
                                        style: TextStyle(color: kGreyColor),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        '${NumberFormat.decimalPattern().format(double.parse(checkPrice(widget.solData!, index).toStringAsFixed(1)))}◎',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  data[index].listing?.listing?.time ??
                                      data[index].transaction!.transactionTime!,
                                  style: const TextStyle(
                                      fontSize: 12, color: kGreyColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            )),
          ])),
    );
  }
}
