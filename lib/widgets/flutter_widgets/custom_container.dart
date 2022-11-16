import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final double? borderRadius;
  final double topLeft;
  final double topRight;
  final double bottomRight;
  final double bottomLeft;
  final BoxBorder? border;
  final Color? color;
  final AlignmentGeometry? alignment;
  final ImageProvider<Object>? backgroundImage;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final void Function()? onTap;

  const CustomContainer({
    this.child,
    this.width,
    this.height,
    this.decoration,
    this.margin,
    this.padding,
    this.borderRadius,
    this.border,
    this.topLeft = 0,
    this.topRight = 0,
    this.bottomLeft = 0,
    this.bottomRight = 0,
    this.color,
    this.alignment,
    this.backgroundImage,
    this.gradient,
    this.onTap,
    this.boxShadow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: decoration ??
            BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: backgroundImage ?? const AssetImage(''),
                onError: (exception, stackTrace) => const Center(
                  child: Icon(Icons.broken_image),
                ),
              ),
              gradient: gradient,
              border: border,
              borderRadius: borderRadius == null &&
                      topLeft == 0 &&
                      topLeft == 0 &&
                      bottomLeft == 0 &&
                      bottomRight == 0
                  ? null
                  : BorderRadius.only(
                      topLeft: Radius.circular(borderRadius ?? topLeft),
                      topRight: Radius.circular(borderRadius ?? topRight),
                      bottomLeft: Radius.circular(borderRadius ?? bottomLeft),
                      bottomRight: Radius.circular(borderRadius ?? bottomRight),
                    ),
              color: color,
              boxShadow: boxShadow,
            ),
        alignment: alignment,
        child: child,
      ),
    );
  }
}
