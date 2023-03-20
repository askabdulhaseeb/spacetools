import 'dart:ui';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/trending.dart';
import '../constants.dart';

class LiveListView extends StatefulWidget {
  const LiveListView({Key? key}) : super(key: key);

  @override
  State<LiveListView> createState() => _LiveListViewState();
}

class _LiveListViewState extends State<LiveListView> {
  var selected;
  bool isOpened = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    liveText(textTheme(context).bodyLarge),
                    const Spacer(
                      flex: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          side: const BorderSide(
                              color: Colors.white, width: 1.5)),
                      child: Text(
                        'CLEAR',
                        style: textTheme(context).bodyMedium,
                      ),
                    ),
                    const Spacer(),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(highlightColor: const Color(0xFF1E1E46)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          items: <String>[
                            'Listing',
                            'Delisting',
                            'Sales',
                            'Bought'
                          ]
                              .map((v) => DropdownMenuItem<String>(
                                    value: v,
                                    child: Text(v),
                                  ))
                              .toList(),
                          value: selected,
                          buttonDecoration: BoxDecoration(
                              color: kLighterColor,
                              border: isOpened
                                  ? Border.all(color: kGreyColor)
                                  : null,
                              borderRadius: BorderRadius.circular(10)),
                          iconOnClick: const Icon(
                            Icons.arrow_downward_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                          onChanged: Trending.isPremium
                              ? (value) {
                                  //print(value);
                                }
                              : null,
                          onMenuStateChange: (isOpen) {
                            // if (isOpen) {
                            //   setState(() {
                            //     isOpened = true;
                            //   });
                            // } else {
                            //   setState(() {
                            //     isOpened = false;
                            //   });
                            // }
                          },
                          icon: const Icon(
                            Icons.arrow_upward_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                          selectedItemHighlightColor: Colors.amber,
                          buttonWidth: 145,
                          buttonHeight: 45,
                          dropdownWidth: 145,
                          dropdownElevation: 0,
                          dropdownDecoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                  color: kGreyColor.withOpacity(.2), width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          buttonPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          hint: Text(
                            'Applied Filters',
                            style: textTheme(context).bodyMedium,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<List>(builder: (context, snapShot) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            width: double.infinity,
                            height: 80,
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Doodles'),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        SvgPicture.asset('assets/Vector.svg'),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        const Text(
                                          '6.87%',
                                          style:
                                              TextStyle(color: Colors.yellow),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Label(
                                          text: 'List',
                                        ),
                                        Text(
                                          ' for ',
                                          style: TextStyle(color: kGreyColor),
                                        ),
                                        Text(
                                          '0.55',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'to ',
                                          style: TextStyle(color: kGreyColor),
                                        ),
                                        Text(
                                          '${'4AWWWeEWwf'.substring(0, 3)}...${'4AWWWeEWwf'.substring(7)}',
                                          style: const TextStyle(
                                              color: Colors.blue),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        SvgPicture.asset('assets/copy.svg')
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      '23% above floor',
                                      style:
                                          TextStyle(color: Color(0xFF00D554)),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      '13 sec ago',
                                      style: TextStyle(
                                          color: kGreyColor, fontSize: 12),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: 80,
                                      child: MaterialButton(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        color: const Color(0xFF00D554),
                                        onPressed: () {},
                                        child: const Text(
                                          'Buy now',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Magic Eden',
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 13),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        SvgPicture.asset(
                                            'assets/external-link.svg'),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: 0,
                            thickness: 1,
                            color: kGreyColor.withOpacity(.2),
                            indent: 20,
                            endIndent: 20,
                          ),
                        ],
                      );
                    },
                  ),
                );
              })
            ],
          ),
        ),
        const LockedFeature()
      ],
    );
  }

  Row liveText(TextStyle? style) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Live',
          style: style,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8, left: 2),
          child: CircleAvatar(
            radius: 3,
            backgroundColor: Colors.red,
          ),
        )
      ],
    );
  }
}

class LockedFeature extends StatelessWidget {
  const LockedFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => dialog(context),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/lock.png',
              height: 40,
            ),
            const Text(
              'Locked feature',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

class Label extends StatelessWidget {
  const Label(
      {Key? key,
      required this.text,
      this.boxColor = Colors.indigoAccent,
      this.color = Colors.blue,
      this.isBlank = false,
      this.random,
      this.icon,
      this.opacity = 0.2,
      this.radius})
      : super(key: key);
  final String text;
  final Color color;
  final Color boxColor;
  final bool isBlank;
  final int? random;
  final dynamic icon;
  final double opacity;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: radius == null
          ? const EdgeInsets.symmetric(horizontal: 2)
          : const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: (!isBlank
                  ? boxColor
                  : random == 1
                      ? Colors.indigoAccent
                      : kGreyColor)
              .withOpacity(opacity),
          borderRadius: BorderRadius.circular(radius ?? 4)),
      child: Row(
        children: [
          icon ?? const SizedBox(),
          Center(
            child: Text(
              !isBlank
                  ? text
                  : random == 1
                      ? 'List'
                      : 'Delist',
              style: TextStyle(
                  color: !isBlank
                      ? color
                      : random == 1
                          ? Colors.blue
                          : kGreyColor),
            ),
          ),
        ],
      ),
    );
  }
}
