import 'package:flutter/material.dart';

Widget customButton({
  required VoidCallback? onPressed,
  required String label,
  double? width,
  double? height,
  Color? backgroundColor,
  // Color? borderColor,
  Color? textColor,
  bool isLoading = false,
  bool isDisabled = false,
  double borderRadius = 12.0,
  double? fontSize = 12.0,
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  BoxBorder? border,
  TextStyle? textStyle,
}) {
  final isClickable = !isLoading && !isDisabled;

  return GestureDetector(
    onTap: isClickable ? onPressed : null,
    child: AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isClickable ? 1.0 : 0.6,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.blue,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,

        ),
        child: isLoading
            ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
        )
            : Text(
          label,
          textAlign: TextAlign.center,
          style: textStyle ??
              TextStyle(
                color: textColor ?? Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    ),
  );
}
