// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:random_string/random_string.dart';

import 'package:spacetools/constants.dart';
import 'package:spacetools/widgets/custom_widget/custom_text_botton.dart';
import 'package:spacetools/widgets/live_list.dart';

class Holdings extends StatefulWidget {
  const Holdings({Key? key}) : super(key: key);

  @override
  State<Holdings> createState() => _SharesState();
}

class _SharesState extends State<Holdings> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CountdownTimerController countdownController;
  late Timer timer;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600), value: 1);
    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await _controller.reverse();
      _controller.forward();
    });
    countdownController = CountdownTimerController(
        endTime:
            DateTime.parse('2023-01-27').millisecondsSinceEpoch + 1000 * 30);
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  double ranDouble(int min, int max) {
    var random = Random();
    return random.nextDouble() * (max - min) + min;
  }

  List<int> randomNumber() {
    int randomNumber = randomBetween(1, 2);
    int longRandomNumber = 3;
    Timer.periodic(
      const Duration(seconds: 30),
      (timer) {
        if (mounted) {
          setState(() {
            randomNumber = randomBetween(1, 2);
          });
        }
      },
    );
    Timer.periodic(
      const Duration(minutes: 30),
      (timer) {
        if (mounted) {
          setState(() {
            longRandomNumber = randomBetween(3, 4);
          });
        }
      },
    );
    return [randomNumber, longRandomNumber];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomTextButton(
              text: 'Overview',
              isActive: true,
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
            ),
            CustomTextButton(
                text: 'Voting',
                isActive: false,
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  dialog(context);
                }),
            CustomTextButton(
                text: 'Activity',
                isActive: false,
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  dialog(context);
                }),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: MyContainer(
                height: 120,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/1.png',
                            height: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Current Holdings',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Expanded(
                        child: Text(
                          'View your shares and standing within the club',
                          style: TextStyle(color: kGreyColor),
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      const Text(
                        'Current Stake: 0%',
                        style: TextStyle(
                            color: kGreenColor, fontWeight: FontWeight.w600),
                      )
                    ]),
              ),
            ),
            Expanded(
              child: MyContainer(
                height: 120,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/2 (1).png',
                            height: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Your Dividends',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      const Text('Next Payout'),
                      CountdownTimer(
                        controller: countdownController,
                        widgetBuilder: (context, time) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TimeWidget(
                                number: time!.days.toString(),
                                label: 'Days',
                              ),
                              const Text(
                                ':',
                                style: TextStyle(fontSize: 20),
                              ),
                              TimeWidget(
                                number: time.hours.toString(),
                                label: 'Hours',
                              ),
                              const Text(
                                ':',
                                style: TextStyle(fontSize: 20),
                              ),
                              TimeWidget(
                                number: time.min.toString(),
                                label: 'Minutes',
                              ),
                            ],
                          );
                        },
                      )
                    ]),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        MyContainer(
            child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Community Voting',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const Text('Marketing Strategy'),
                  const SizedBox(
                    height: 5,
                  ),
                  LinearPercentIndicator(
                      animation: true,
                      lineHeight: 12,
                      width: 160,
                      percent: 0,
                      backgroundColor: kLighterColor,
                      barRadius: const Radius.circular(10),
                      center: const Text(
                        '0%',
                        style: TextStyle(fontSize: 10),
                      ),
                      linearGradient: const LinearGradient(
                        colors: [
                          Color(0xFFF533FF),
                          Color(0xFF336CFF),
                          Color(0xFF35D3FF)
                        ],
                        end: Alignment(2, 4),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Opens: 01/07/2023 7PM EST',
                        style: TextStyle(color: kGreyColor, fontSize: 12),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 137,
              height: 47,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    dialog(context);
                  },
                  child: const Text(
                    'Vote Now',
                  )),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        )),
        const SizedBox(
          height: 20,
        ),
        MyContainer(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Live',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  FadeTransition(
                    opacity: _controller,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: CircleAvatar(
                        backgroundColor: kRedColor,
                        radius: 3,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'In:   ',
                            style: TextStyle(color: kGreyColor),
                          ),
                          LinearPercentIndicator(
                            width: 120,
                            percent: randomNumber()[0] == 1 ? .9 : .88,
                            progressColor: kGreenColor,
                            animation: true,
                            animateFromLastPercent: true,
                            barRadius: const Radius.circular(10),
                            backgroundColor: Colors.transparent,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Out:',
                            style: TextStyle(color: kGreyColor),
                          ),
                          LinearPercentIndicator(
                            width: 120,
                            animation: true,
                            animateFromLastPercent: true,
                            percent: randomNumber()[0] == 1 ? .48 : .5,
                            progressColor: kRedColor,
                            barRadius: const Radius.circular(10),
                            backgroundColor: Colors.transparent,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      dialog(context);
                    },
                    child: const Text('Explore'),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/Pool.png',
                      height: 132,
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 15, right: 8),
                        color: Colors.black,
                        child: const Text('The Club',
                            style: TextStyle(fontSize: 11)))
                  ],
                ),
                const SizedBox(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total available liquidity',
                      style: TextStyle(color: kGreyColor, fontSize: 15),
                    ),
                    Text(
                      '\$${NumberFormat().format(double.parse((randomNumber()[1] == 3 ? randomNumber()[0] == 1 ? 127704.20 + ranDouble(10, 200) : 127704.20 - ranDouble(10, 200) : randomNumber()[0] == 1 ? 127704.20 + ranDouble(1000, 2000) : 127704.20 - ranDouble(1000, 2000)).toStringAsFixed(2)))}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      'Total liquidity',
                      style: TextStyle(color: kGreyColor, fontSize: 15),
                    ),
                    Text(
                      '\$${NumberFormat().format(double.parse((randomNumber()[1] == 3 ? randomNumber()[0] == 1 ? 171033.75 + ranDouble(10, 200) : 171033.75 - ranDouble(10, 200) : randomNumber()[0] == 1 ? 171033.75 + ranDouble(1000, 2000) : 171033.75 - ranDouble(1000, 2000)).toStringAsFixed(2)))}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
                color: kGreyColor.withOpacity(.2), thickness: 1.5, height: 25),
            SizedBox(
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: const [
                  Label(
                    text: 'Reserve',
                    color: Colors.indigoAccent,
                    boxColor: Colors.indigoAccent,
                    radius: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Label(
                    text: 'The Crew',
                    color: Colors.lightBlue,
                    boxColor: Colors.lightBlue,
                    radius: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Label(
                    text: 'Dividend Pool',
                    color: Colors.deepPurpleAccent,
                    boxColor: Colors.deepPurpleAccent,
                    radius: 10,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Label(
                    text: 'Community & Ecosystem',
                    color: kGreenColor,
                    boxColor: kGreenColor,
                    radius: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6)
          ],
        )),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Proposals',
                style: textTheme(context).bodyLarge,
              ),
            ),
            const SizedBox(height: 10),
            const AddSth(
              subject: 'Proposals',
              height: 280,
              caption: 'There are currently no proposals to display',
            )
          ],
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}

class AddSth extends StatelessWidget {
  const AddSth({
    Key? key,
    this.height = 250,
    this.hasButton = true,
    required this.subject,
    required this.caption,
  }) : super(key: key);
  final double height;
  final bool hasButton;
  final String subject;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return MyContainer(
        height: height,
        child: Stack(
          children: [
            hasButton
                ? Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        CustomTextButton(
                          text: 'Recent',
                          isActive: true,
                          onTap: () {},
                        ),
                        CustomTextButton(
                          text: 'View All',
                          isActive: false,
                          onTap: () {
                            dialog(context);
                          },
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.only(top: 160),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Create New $subject',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      caption,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: kGreyColor, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => dialog(context),
              child: Center(
                  child: ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF666671), Color(0xFF323248)])
                      .createShader(bounds);
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white.withOpacity(.42),
                  child: Stack(
                    children: List.generate(
                      30,
                      (index) => SvgPicture.asset(
                        'assets/Plus2.svg',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )),
            ),
          ],
        ));
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    Key? key,
    required this.number,
    required this.label,
  }) : super(key: key);
  final String number;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
            color: const Color(0xFF1B1B22),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: kGreyColor),
            )
          ],
        ));
  }
}

class MyContainer extends StatelessWidget {
  const MyContainer(
      {Key? key, required this.child, this.width, this.height, this.color})
      : super(key: key);
  final Widget child;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
          color: const Color(0xCC08080E),
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}
