import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spacetools/Model/edu_model.dart';
import 'package:spacetools/data.dart';
import '../constants.dart';
import '../widgets/live_list.dart';
import '../widgets/mint.dart';

class EduClasses extends StatefulWidget {
  const EduClasses({Key? key}) : super(key: key);

  @override
  State<EduClasses> createState() => _EduClassesState();
}

class _EduClassesState extends State<EduClasses> {
  late Timer timer;
  final List<Color> colors = <Color>[
    Color(0xFF00D554),
    Colors.purpleAccent,
    Colors.lightBlueAccent,
    Colors.yellow,
    Colors.orange,
    Colors.blue,
    Color(0xFF2152FF),
  ];

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      index == 0
          ? controller.nextPage(
              duration: const Duration(seconds: 1), curve: Curves.easeOutCubic)
          : controller.previousPage(
              duration: const Duration(seconds: 1), curve: Curves.easeOutCubic);
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  int index = 0;
  final controller = PageController();
  final List<EduModel> classes = edutionData();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          Text(
            'Exclusive Lectures',
            style: textTheme(context).bodyLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 160,
            child: PageView.builder(
              controller: controller,
              onPageChanged: (value) {
                if (mounted) {
                  setState(() {
                    index = value;
                  });
                }
              },
              itemCount: 2,
              itemBuilder: (context, index) {
                return EduCard(
                  title: index == 0
                      ? 'Steven Boykey Sidley'
                      : 'Jonathan Reichental',
                  caption: index == 0
                      ? 'How crypto is redefining ownership'
                      : 'Zero-to Sixty Crypto Investing',
                  date: index == 0 ? '7th February 2023' : '11th February 2023',
                  time: '',
                  colors: colors,
                  tags: [
                    'Crypto',
                    index == 0 ? 'DeFi' : 'Investing',
                    index == 0 ? 'Metaverse' : 'Psychology',
                  ],
                  // labelColor2: index == 0 ? Colors.purpleAccent : Colors.blue,
                  // labelColor3: index == 0 ? Colors.orange : Colors.yellow,
                  isAssetsImage: index == 1 ? true : false,
                  image: index == 0
                      ? 'assets/Zdujb602_400x400.png'
                      : 'assets/jonathan.png',
                  hasImage: true,
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 35,
                  height: 3,
                  decoration: BoxDecoration(
                      color: index == 0 ? Colors.white : kLighterColor,
                      borderRadius: BorderRadius.circular(5))),
              const SizedBox(width: 10),
              Container(
                width: 35,
                height: 3,
                decoration: BoxDecoration(
                    color: index == 1 ? Colors.white : kLighterColor,
                    borderRadius: BorderRadius.circular(5)),
              )
            ],
          ),
          const SizedBox(height: 15),
          Text(
            'Upcoming Classes',
            style: textTheme(context).bodyLarge,
          ),
          // const SizedBox(height: 10),
          // const EduCard(title: 'Crypto Trading'),
          // const SizedBox(height: 10),
          // const EduCard(
          //     title: 'Learn to Code: Python',
          //     labelText2: 'Coding',
          //     labelColor2: Colors.deepOrangeAccent),
          // const SizedBox(height: 10),
          // const EduCard(
          //   title: 'Investors Secrets',
          //   labelText2: 'Investing',
          //   labelColor2: Colors.lightBlue,
          // ),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: classes.length,
            itemBuilder: (context, index) {
              final EduModel myClass = classes[index];
              return EduCard(
                title: myClass.title,
                tags: myClass.tags,
                caption: myClass.caption,
                duration: myClass.duration,
                time: myClass.time,
                date: myClass.date,
                colors: colors,
              );
            },
          )
        ],
      ),
    );
  }
}

class EduCard extends StatefulWidget {
  const EduCard({
    Key? key,
    required this.title,
    required this.tags,
    required this.colors,
    this.date = 'Nov 4th 2022',
    this.time = '05:00 PM',
    this.caption =
        'A compete guide to advanced cryptocurrency trading and investment strategy',
    this.hasImage = false,
    this.duration = '1hr 45min',
    this.image =
        'https://pbs.twimg.com/profile_images/1145968062140702721/Zdujb602_400x400.png',
    this.isAssetsImage = false,
  }) : super(key: key);
  final String title;
  final String duration;
  final String date;
  final String time;
  final String caption;
  final bool hasImage;
  final String image;
  final List<Color> colors;
  final bool isAssetsImage;
  final List<String> tags;

  @override
  State<EduCard> createState() => _EduCardState();
}

class _EduCardState extends State<EduCard> {
  @override
  void initState() {
    super.initState();
    widget.colors.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          widget.hasImage
              ? Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    widget.isAssetsImage
                        ? Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width /
                                        2.2),
                                decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                        radius: 1,
                                        colors: [
                                      Colors.white.withOpacity(.4),
                                      Colors.transparent
                                    ])),
                              ),
                              Positioned(
                                right: -40,
                                child: Image.asset(
                                  widget.image,
                                  height: 160,
                                ),
                              ),
                            ],
                          )
                        : Image.asset(
                            widget.image,
                            height: 160,
                          ),
                    if (widget.hasImage)
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black87),
                            onPressed: () => dialog(context),
                            child: const Text('Learn More')),
                      )
                  ],
                )
              : Positioned(
                  bottom: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => dialog(context),
                        child: const OutlineGradientButton(
                          text: 'Free for Members',
                          size: 13,
                        ),
                      ),
                      SizedBox(
                        height: 37,
                        child: TextButton(
                            onPressed: () => dialog(context),
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                            child: const Text(
                              'Book',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            )),
                      ),
                      const SizedBox(width: 5)
                    ],
                  ),
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.date,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.time,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const Spacer(),
                  widget.hasImage
                      ? const SizedBox()
                      : SvgPicture.asset('assets/clock.svg'),
                  const SizedBox(
                    width: 5,
                  ),
                  widget.hasImage
                      ? const SizedBox()
                      : Text(
                          widget.duration,
                          style: const TextStyle(fontSize: 13),
                        )
                ],
              ),
              SizedBox(
                width: 222,
                child: Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: widget.hasImage ? 24 : 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                widget.caption,
                style: const TextStyle(color: kGreyColor, fontSize: 13),
              ),
              const SizedBox(height: 4),
              // SizedBox(
              //   height: 25,
              //   width: MediaQuery.of(context).size.width / 2,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: [
              //       Label(
              //         text: labelText1,
              //         radius: 30,
              //         color: labelColor1,
              //         boxColor: labelColor1,
              //       ),
              //       SizedBox(width: hasImage ? 0 : 4),
              //       Label(
              //         text: labelText2,
              //         radius: 30,
              //         color: labelColor2,
              //         boxColor: labelColor2,
              //       ),
              //       hasImage
              //           ? Label(
              //               text: labelText3,
              //               radius: 30,
              //               color: labelColor3,
              //               boxColor: labelColor3,
              //             )
              //           : const SizedBox(),
              //       // Label(
              //       //   text: labelText3,
              //       //   radius: 30,
              //       //   color: labelColor3,
              //       //   boxColor: labelColor3,
              //       // )
              //     ],
              //   ),
              // )
              SizedBox(
                height: 25,
                width: MediaQuery.of(context).size.width / 2 -
                    (widget.hasImage ? 0 : 30),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      widget.tags.length,
                      (index) => Label(
                            text: widget.tags[index],
                            boxColor: widget.colors[index],
                            color: widget.colors[index],
                            radius: 30,
                          )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
