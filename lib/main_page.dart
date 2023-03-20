import 'dart:io';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import './pages/home.dart';
import 'constants.dart';
import 'pages/nft.dart';
import 'pages/game.dart';
import 'pages/defi.dart';
import 'pages/education.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.address}) : super(key: key);
  final String address;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void onTap(int index) {
    realIndex.value = index;
    _pageController.jumpToPage(index);
  }

  Color itemColor(int currentIndex, int index) {
    return currentIndex == index ? Colors.white : kGreyColor;
  }

  final ValueNotifier<int> realIndex = ValueNotifier<int>(2);
  //int currentIndex = 2;
  late final PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: realIndex.value);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
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
                Colors.black,
                const Color(0xFF010187).withOpacity(.6),
                const Color(0xFFC41BFF),
              ],
            )),
          ),
        ),
        PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            NFTPage(
              address: widget.address,
            ),
            Defi(address: widget.address),
            Home(
              address: widget.address,
            ),
            Game(
              address: widget.address,
            ),
            Education(
              address: widget.address,
            ),
          ],
        )
      ]),
      extendBody: true,
      bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: realIndex,
          builder: (context, currentIndex, child) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                FloatingNavbar(
                    onTap: onTap,
                    fontSize: 13,
                    borderRadius: 16,
                    // margin: Platform.isAndroid
                    //     ? const EdgeInsets.only(bottom: 10)
                    //     : EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: kGreyColor,
                    selectedBackgroundColor: Colors.transparent,
                    backgroundColor: Colors.black.withOpacity(.89),
                    currentIndex: currentIndex,
                    items: [
                      FloatingNavbarItem(
                          title: 'NFT',
                          customWidget: SvgPicture.asset(
                            'assets/Tab_1.svg',
                            height: 15,
                            color: itemColor(currentIndex, 0),
                          )),
                      FloatingNavbarItem(
                          title: 'DeFi',
                          customWidget: SvgPicture.asset(
                            'assets/Tab_2.svg',
                            height: 15,
                            color: itemColor(currentIndex, 1),
                          )),
                      FloatingNavbarItem(
                        customWidget: const SizedBox(),
                      ),
                      FloatingNavbarItem(
                          title: 'Game',
                          customWidget: SvgPicture.asset(
                            'assets/Tab_3.svg',
                            height: 15,
                            color: itemColor(currentIndex, 3),
                          )),
                      FloatingNavbarItem(
                        title: 'Education',
                        customWidget: SvgPicture.asset(
                          'assets/Tab_4.svg',
                          height: 15,
                          color: itemColor(currentIndex, 4),
                        ),
                      ),
                    ]),
                Positioned(
                    top: 0,
                    child: GestureDetector(
                        onTap: () {
                          realIndex.value = 2;
                          _pageController.jumpToPage(2);
                        },
                        child: const Logo()))
              ],
            );
          }),
    );
  }
}
