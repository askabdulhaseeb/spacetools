import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class CustomSlidingText extends StatelessWidget {
  const CustomSlidingText({
    Key? key,
    this.text =
        'Please Note: You are in Demo Mode - Some market data may be delayed |',
    this.boxColor = Colors.indigoAccent,
    this.color = Colors.blue,
    this.opacity = 0.2,
    this.radius,
  }) : super(key: key);
  final String text;
  final Color color;
  final Color boxColor;
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
          color: boxColor.withOpacity(opacity),
          borderRadius: BorderRadius.circular(radius ?? 4)),
      child: Marquee(
        text: text,
        blankSpace: 4,
        velocity: 30,
        pauseAfterRound: const Duration(seconds: 2),
        style: TextStyle(color: boxColor),
      ),
    );
  }
}
