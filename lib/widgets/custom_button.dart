import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isOutlined;
  final double? width;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.isOutlined = false,
    this.width,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: backgroundColor ?? Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: textColor ?? backgroundColor ?? Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ?? Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
