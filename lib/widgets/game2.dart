import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import '../constants.dart';
import 'custom_widget/app_bar.dart';

class Game2 extends StatelessWidget {
  const Game2({Key? key, required this.address}) : super(key: key);
  final String address;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/Background.png'),
        RotatedBox(
          quarterTurns: 45,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.black,
                Colors.black,
                Colors.black,
                Colors.black,
                const Color(0xFF010187).withOpacity(.4),
                const Color(0xFFC41BFF),
              ],
            )),
          ),
        ),
        GameWidget(
          address: address,
          isGame2: true,
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            size: 20,
          ),
          onTap: () {
            Navigator.pop(context);
          },
          division: 7,
          headline: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Whoa there Space Cadet!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ),
          image: 'assets/111 1.png',
          widget: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: const TextStyle(color: Colors.grey),
                  children: [
                    const TextSpan(
                        text:
                            'You need full clearance to enter New Space.\n\n'),
                    const TextSpan(text: 'Enter your phygital key or go to\n'),
                    WidgetSpan(
                        child: SelectableLinkify(
                      text: 'www.thespaceclub.xyz',
                      onTap: () async => await openWebsite(),
                    )),
                    const TextSpan(text: ' to try out the demo'),
                  ])),
        ),
      ],
    );
  }
}

class GameWidget extends StatelessWidget {
  const GameWidget(
      {Key? key,
      required this.address,
      required this.headline,
      required this.widget,
      required this.image,
      this.division = 5,
      this.onTap,
      this.icon,
      this.isGame2 = false})
      : super(key: key);
  final String address;
  final Widget headline;
  final Widget widget;
  final String image;
  final int division;
  final bool isGame2;
  final VoidCallback? onTap;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: buildAppBar(
          context,
          [],
          isTabbarNeeded: false,
          address: address,
          icon: icon,
          onTap: onTap,
          isGame: isGame2,
          isEmpty: true,
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height / division,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Image.asset(
                    image,
                    height: 350,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  headline,
                  const SizedBox(
                    height: 30,
                  ),
                  widget
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LoadPage extends StatelessWidget {
  const LoadPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'spacetoolss',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(colors: [
                            Color(0xFFF533FF),
                            Color(0xFF336CFF),
                            Color(0xFF35D3FF)
                          ]).createShader(bounds);
                        },
                        child: const Text('Beta'))
                  ],
                ),
                Text(
                  'TSC Innovations LTD (c) 2022 All Rights Reserved.',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                )
              ],
            ),
          ),
          const Center(
            child: Logo(
              isLoading: true,
            ),
          ),
        ],
      ),
    );
  }
}
