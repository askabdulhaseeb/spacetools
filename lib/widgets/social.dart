import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Model/biggest_whale_top_traders.dart';
import '../constants.dart';

class Social extends StatelessWidget {
  const Social(
      {Key? key,
      required this.title,
      required this.future,
      required this.isEth})
      : super(key: key);
  final String title;
  final Future<BiggestWhalesAndTopTraders> future;
  final bool isEth;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat.decimalPattern();
    if (isEth) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: textTheme(context).bodyLarge),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 67,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 330,
                      decoration: BoxDecoration(
                          color: const Color(0xCC08080E),
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        onTap: () => dialog(context),
                        horizontalTitleGap: 7,
                        leading: Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: kGreyColor,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        title: const Text(
                          '@DontsellyourETH',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Sold'),
                            Expanded(
                              child: Text(
                                'Jelly...',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            Text('for'),
                            Text(
                              '65◎',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        trailing: SizedBox(
                            width: 90,
                            child: Row(
                              children: [
                                const VerticalDivider(
                                  color: kGreyColor,
                                  width: 0,
                                  indent: 5,
                                  endIndent: 7,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Net Worth',
                                      style: TextStyle(color: kGreyColor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '\$290,051',
                                    )
                                  ],
                                )
                              ],
                            )),
                      ));
                },
              ),
            )
          ],
        ),
      );
    }
    return FutureBuilder<BiggestWhalesAndTopTraders>(
        future: future,
        builder: (context, snapshot) {
          final data = snapshot.data?.listSocialItems;
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme(context).bodyLarge),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 67,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 330,
                            decoration: BoxDecoration(
                                color: const Color(0xCC08080E),
                                borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              onTap: () => dialog(context),
                              horizontalTitleGap: 7,
                              leading: Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        onError: (exception, stackTrace) {
                                          debugPrint('error');
                                        },
                                        image: NetworkImage(
                                            data[index].profileImageUrl ?? '')),
                                    color: kGreyColor,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              title: Text(
                                data[index].actor!.twitterName!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16),
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '${data[index].lastTransactionDirection!.name.capitalize()} '),
                                  Expanded(
                                    child: Text(
                                      data[index].collectionName!,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                  const Text('for'),
                                  Text(
                                    '${formatNumber(data[index].lastTransactionPriceSol!)}◎',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: SizedBox(
                                  width: 90,
                                  child: Row(
                                    children: [
                                      const VerticalDivider(
                                        color: kGreyColor,
                                        width: 0,
                                        indent: 5,
                                        endIndent: 7,
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Net Worth',
                                            style: TextStyle(color: kGreyColor),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '\$${formatter.format(double.parse(data[index].totalPortfolioValueUsd!.toStringAsFixed(1)))}',
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                            ));
                      },
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
