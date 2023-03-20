import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.text,
    required this.isActive,
    required this.onTap,
    this.padding,
    this.borderRadius,
    Key? key,
  }) : super(key: key);
  final String text;
  final bool isActive;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 15),
            backgroundColor: isActive ? kLighterColor : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(10),
            )),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : kGreyColor.withOpacity(.5),
          ),
        ));
  }
}
