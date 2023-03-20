import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:spacetools/Model/eth_trending_top.dart';
import 'package:url_launcher/url_launcher.dart';
import './Model/trending.dart';
import 'Model/recent_activity.dart';

const kLighterColor = Color(0xFF1c1c1e);
const kGreenColor = Color(0xFF00D554);
const kGreenColor2 = Color(0xFF3DFF96);
const kRedColor = Color(0xFFFF2929);
const kRedColor2 = Color(0xFFFF2929);
const kPurpleColor = Color(0xFF8E38E3);
const kPurpleColor2 = Color(0xF38E38E3);
const kGreyColor = Color(0xFF828294);

const String subscriptionText = 'Unlock the power spacetoolss';
TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;

formatNumber(double number) {
  return NumberFormat.compact().format(number);
}

final format = NumberFormat.decimalPattern();

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

Future<void> openWebsite({String url = 'https://www.thespaceclub.xyz'}) async {
  final Uri uRL = Uri.parse(url);
  if (!await launchUrl(uRL)) {
    throw 'Could not launch $uRL';
  }
}

void dialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.black45,
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.symmetric(horizontal: 12),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(width: 2, color: Colors.grey.withOpacity(.3))),
      content: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset('assets/Padlock.svg'),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 30,
                          )),
                    )
                  ],
                ),
                const Text(
                  subscriptionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
                dialogColumn(),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.all(20)),
                    onPressed: () async => await openWebsite(),
                    child: const Text(
                      'FIND OUT MORE',
                      style: TextStyle(fontSize: 16),
                    )),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget dialogColumn() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/gem-stone_1f48e.png',
            height: 55,
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Go Premium',
                style: TextStyle(color: kGreyColor, fontSize: 16),
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(text: '0.50 ', style: TextStyle(fontSize: 24)),
                WidgetSpan(
                    child: Image.asset(
                  'assets/Ethereum (ETH).png',
                  height: 22,
                )),
                const TextSpan(
                    text: ' /Quarterly',
                    style: TextStyle(color: kGreyColor, fontSize: 16))
              ]))
            ],
          )
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/jet.png',
            height: 55,
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'The Space Club',
                style: TextStyle(color: kGreyColor, fontSize: 16),
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: '0 ',
                    style: TextStyle(fontSize: 24, color: Colors.tealAccent)),
                WidgetSpan(
                    child: Image.asset(
                  'assets/Ethereum (ETH) (1).png',
                  height: 22,
                )),
                const TextSpan(
                    text: ' Free for members',
                    style: TextStyle(color: Colors.tealAccent, fontSize: 16))
              ]))
            ],
          )
        ],
      ),
    ],
  );
}

Color checkCoinColor(String priceChange) {
  late final Color color;
  double change = double.parse(priceChange);
  if (change > 0) {
    color = kGreenColor;
  } else if (change < 0) {
    color = kRedColor;
  } else {
    color = Colors.grey;
  }
  return color;
}

dynamic checkCoinIcon(String priceChange) {
  late final icon;
  double change = double.parse(priceChange);
  if (change > 0) {
    icon = const Icon(
      Icons.arrow_drop_up_sharp,
      color: kGreenColor,
      size: 18,
    );
  } else if (change < 0) {
    icon = const Icon(
      Icons.arrow_drop_down_sharp,
      color: kRedColor,
      size: 18,
    );
  } else {
    icon = const Text(
      '  - ',
      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
    );
  }
  return icon;
}

List<Color> checkColor(
  ColorValues colorValues,
) {
  late final Color color;
  late final Color color2;
  if (colorValues == ColorValues.gray) {
    color = Colors.grey;
    color2 = Colors.grey.shade400;
  }
  if (colorValues == ColorValues.f73c63) {
    color = kRedColor;
    color2 = kRedColor;
  }
  if (colorValues == ColorValues.the20EFB9) {
    color = kGreenColor;
    color2 = kGreenColor2;
  }
  return [color, color2];
}

List<Color> ethCheckColor(
  ChangeColor colorValues,
) {
  late final Color color;
  late final Color color2;
  if (colorValues == ChangeColor.gray) {
    color = Colors.grey;
    color2 = Colors.grey.shade400;
  }
  if (colorValues == ChangeColor.red) {
    color = kRedColor;
    color2 = kRedColor;
  }
  if (colorValues == ChangeColor.green) {
    color = kGreenColor;
    color2 = kGreenColor2;
  }
  return [color, color2];
}

dynamic iconCheck(ColorValues colorValues) {
  late final icon;
  if (colorValues == ColorValues.gray) {
    icon = const Text(
      '- ',
      style: TextStyle(fontWeight: FontWeight.w600),
    );
  }
  if (colorValues == ColorValues.the20EFB9) {
    icon = const Icon(
      Icons.arrow_drop_up_sharp,
      color: kGreenColor,
      size: 18,
    );
  }
  if (colorValues == ColorValues.f73c63) {
    icon = const Icon(
      Icons.arrow_drop_down_sharp,
      color: kRedColor,
      size: 18,
    );
  }
  return icon;
}

dynamic ethIconCheck(ChangeColor changeColor) {
  late final icon;
  if (changeColor == ChangeColor.gray) {
    icon = const Text(
      '- ',
      style: TextStyle(fontWeight: FontWeight.w600),
    );
  }
  if (changeColor == ChangeColor.green) {
    icon = const Icon(
      Icons.arrow_drop_up_sharp,
      color: kGreenColor,
      size: 18,
    );
  }
  if (changeColor == ChangeColor.red) {
    icon = const Icon(
      Icons.arrow_drop_down_sharp,
      color: kRedColor,
      size: 18,
    );
  }
  return icon;
}

dynamic ethNFTIconCheck(ChangeColor changeColor) {
  late final icon;
  if (changeColor == ChangeColor.gray) {
    icon = const Text(
      '- ',
      style: TextStyle(fontWeight: FontWeight.w600),
    );
  }
  if (changeColor == ChangeColor.green) {
    icon = const Icon(
      Icons.arrow_drop_up_sharp,
      color: kGreenColor,
      size: 18,
    );
  }
  if (changeColor == ChangeColor.red) {
    icon = const Icon(
      Icons.arrow_drop_down_sharp,
      color: kRedColor,
      size: 18,
    );
  }
  return icon;
}

String checkType(RecentActivityData recentActivityData, int index) {
  late final String type;
  if (recentActivityData.socialActivities[index].lastTransactionDirection !=
      null) {
    type = recentActivityData.socialActivities[index].lastTransactionDirection!
        .capitalize();
  } else if (recentActivityData
          .socialActivities[index].listing?.listing?.type !=
      null) {
    if (recentActivityData.socialActivities[index].listing!.listing!.type! ==
        Type.cancel) {
      type = 'Delist';
    } else {
      type = 'List';
    }
  } else {
    if (recentActivityData.socialActivities[index].transaction!.saleType ==
        SaleType.buyer) {
      type = 'Bought';
    } else {
      type = 'Sold';
    }
  }
  return type;
}

Color checkTypeColor(RecentActivityData recentActivityData, int index,
    {required Color purpleColor}) {
  late final Color color;
  if (recentActivityData.socialActivities[index].lastTransactionDirection !=
      null) {
    if (recentActivityData.socialActivities[index].lastTransactionDirection! ==
        'sold') {
      color = kRedColor;
    } else {
      color = purpleColor;
    }
  } else if (recentActivityData
          .socialActivities[index].listing?.listing?.type !=
      null) {
    if (recentActivityData.socialActivities[index].listing!.listing!.type! ==
        Type.cancel) {
      color = Colors.grey;
    } else {
      color = Colors.blue;
    }
  } else {
    if (recentActivityData.socialActivities[index].transaction!.saleType ==
        SaleType.seller) {
      color = kRedColor;
    } else {
      color = purpleColor;
    }
  }
  return color;
}

class Logo extends StatelessWidget {
  final bool isLoading;
  const Logo({Key? key, this.isLoading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShaderMask shader(Widget child) {
      return ShaderMask(
          shaderCallback: (bounds) {
            return const LinearGradient(colors: [
              Color(0xFFF533FF),
              Color(0xFF336CFF),
              Color(0xFF35D3FF)
            ]).createShader(bounds);
          },
          child: child);
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        shader(SvgPicture.asset(
          'assets/Ellipse543.svg',
          height: isLoading ? null : 66,
          width: isLoading ? null : 66,
        )),
        shader(SvgPicture.asset(
          'assets/Vector1.svg',
          height: isLoading ? null : 66,
          width: isLoading ? null : 72,
        )),
        shader(SvgPicture.asset(
          'assets/Vector-1.svg',
          height: isLoading ? null : 66,
          width: isLoading ? null : 72,
        )),
        shader(SvgPicture.asset(
          'assets/Vector-2.svg',
          height: isLoading ? null : 72,
          width: isLoading ? null : 72,
        )),
        SvgPicture.asset(
          'assets/Logo S 2 (1).svg',
          height: isLoading ? null : 24,
          width: isLoading ? null : 32,
        ),
      ],
    );
  }
}
