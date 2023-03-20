import 'dart:ui';

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../Model/wallet.dart';
import '../../constants.dart';
import '../../pages/login_screen2.dart';
import '../live_list.dart';

AppBar buildAppBar(
  BuildContext context,
  List<String> labels, {
  bool isTabbarNeeded = true,
  required String address,
  Icon? icon,
  bool isEmpty = false,
  bool isGame = false,
  Future<SolWalletData>? future,
  ValueListenable<bool>? isTapped,
  VoidCallback? onTap,
}) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  var box = Hive.box('address');
  var worthBox = Hive.box('worth');
  var color = kGreyColor;
  return AppBar(
    backgroundColor: Colors.transparent,
    scrolledUnderElevation: 0,
    bottom: PreferredSize(
        preferredSize: const Size.fromHeight(106),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: isEmpty
                              ? isGame
                                  ? GestureDetector(onTap: onTap, child: icon)
                                  : const SizedBox()
                              : ValueListenableBuilder<bool>(
                                  valueListenable: isTapped!,
                                  builder: (context, isSol, child) {
                                    return Row(
                                      children: [
                                        GestureDetector(
                                          onTap: onTap,
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: isSol
                                                ? BoxDecoration(
                                                    color: kLighterColor,
                                                    border: Border.all(
                                                        color: kGreyColor
                                                            .withOpacity(.4)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100))
                                                : null,
                                            child: Center(
                                              child: Image.asset(
                                                'assets/Solana (SOL) (1).png',
                                                height: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                          onTap: onTap,
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: !isSol
                                                ? BoxDecoration(
                                                    color: kLighterColor,
                                                    border: Border.all(
                                                        color: kGreyColor
                                                            .withOpacity(.4)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100))
                                                : null,
                                            child: Center(
                                              child: Image.asset(
                                                'assets/eth.png',
                                                height: 25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                        ),
                        InkWell(
                          customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          onTap: () => dialog(context),
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Stack(
                              children: [
                                const Align(
                                  alignment: Alignment.topRight,
                                  child: CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.lightBlueAccent,
                                  ),
                                ),
                                Center(
                                    child: SvgPicture.asset(
                                        'assets/notification2.svg')),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Image.asset(
                              'assets/Avatar.png',
                              height: 55,
                            ),
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.black.withOpacity(.9),
                              child: Center(
                                  child: SvgPicture.asset(
                                'assets/settings2.svg',
                                height: 12,
                              )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        StatefulBuilder(builder: (context, setState) {
                          return CustomPopupMenu(
                              pressType: PressType.singleClick,
                              showArrow: false,
                              menuOnChange: (val) {
                                if (val) {
                                  setState(
                                    () {
                                      color = Colors.white;
                                    },
                                  );
                                } else {
                                  setState(
                                    () {
                                      color = kGreyColor;
                                    },
                                  );
                                }
                              },
                              menuBuilder: () {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 15, sigmaY: 15),
                                    child: Container(
                                      //margin: const EdgeInsets.symmetric(horizontal: 5),
                                      padding: const EdgeInsets.all(15),
                                      height: 215,
                                      decoration: BoxDecoration(
                                          color: Colors.black45,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color:
                                                  kGreyColor.withOpacity(.3))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                'Current Wallet',
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 16),
                                              ),
                                              Label(
                                                text:
                                                    'demo only supports one wallet',
                                                color: Colors.lightBlueAccent,
                                                boxColor:
                                                    Colors.lightBlueAccent,
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            box.get('address'),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          FutureBuilder<SolWalletData>(
                                              future: future,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  worthBox.put('worth',
                                                      '\$${NumberFormat().format(snapshot.data!.totalUsdt)}');
                                                  return Text(
                                                    '\$${NumberFormat().format(snapshot.data!.totalUsdt)}',
                                                    //'\$11,043',
                                                    style: const TextStyle(
                                                        color: Colors
                                                            .lightBlueAccent,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  );
                                                } else if (snapshot
                                                        .connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Text(
                                                    'Loading...',
                                                    //'\$11,043',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .lightBlueAccent,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  );
                                                } else {
                                                  return Text(
                                                    worthBox.get('worth') ?? '',
                                                    //'\$11,043',
                                                    style: const TextStyle(
                                                        color: Colors
                                                            .lightBlueAccent,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  );
                                                }
                                              }),
                                          const Spacer(
                                            flex: 3,
                                          ),
                                          CustomForm(
                                            controller: controller,
                                            formKey: formKey,
                                            mounted: true,
                                          ),
                                          const Spacer()
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${(address).substring(0, 4)}...${address.substring(address.length - 4)}',
                                    style: TextStyle(color: color),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  RotatedBox(
                                    quarterTurns: color == kGreyColor ? 0 : 90,
                                    child: SvgPicture.asset(
                                      'assets/arrow_down.svg',
                                      height: 5,
                                      color: color,
                                    ),
                                  )
                                ],
                              ));
                        })
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: labels.length > 2
                        ? 20
                        : labels.length == 3
                            ? 50
                            : 80),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: isTabbarNeeded
                    ? TabBar(
                        indicatorPadding:
                            const EdgeInsets.symmetric(horizontal: 4),
                        splashBorderRadius: BorderRadius.circular(20),
                        tabs: List.generate(
                            labels.length,
                            (index) => Tab(
                                  text: labels[index],
                                  height: 40,
                                )),
                        indicator: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          gradient: const LinearGradient(colors: [
                            Color(0xFFF533FF),
                            Color(0xFF336CFF),
                            Color(0xFF35D3FF)
                          ]),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        )),
  );
}
