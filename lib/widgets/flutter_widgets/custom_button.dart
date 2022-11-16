import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget? child;
  final void Function()? onPressed;
  final Color? buttonColor;
  final double? minWidth;
  final double? height;
  final double? borderRadius;
  final double? elevation;
  const CustomButton({
    this.child,
    this.elevation,
    this.onPressed,
    this.buttonColor,
    this.minWidth,
    this.height,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: elevation,
      onPressed: onPressed,
      minWidth: minWidth,
      height: height,
      color: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius == null
            ? BorderRadius.zero
            : BorderRadius.circular(borderRadius!),
      ),
      child: child,
    );
  }
}
