import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({ 
    Key? key,
    required this.text,
    required this.onPressed,
    required this.buttonBgColor,
    required this.fontColor,
    this.isLoading,
    this.fontSize,
    this.style,
    this.width, this.textStyle, this.buttonRadius, this.height, this.buttonContent
  }) : super(key: key);

  final Widget ? buttonContent;
  final String text; 
  final VoidCallback onPressed;
  final Color buttonBgColor;
  final Color fontColor;
  final dynamic fontSize;
  final bool? isLoading;
  final dynamic style;
  final TextStyle? textStyle;
  final double? buttonRadius;
  // ignore: prefer_typing_uninitialized_variables
  final width, height;


  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      height: widget.height ?? 48.0.h,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: widget.style ?? ElevatedButton.styleFrom(
          elevation: 0.5,
          backgroundColor: widget.buttonBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.buttonRadius ?? 4.r),
          ),
        ), 
        child: widget.buttonContent ??Text(
          widget.text,
          style: widget.textStyle ?? const TextStyle(),
        ),
      ),
    );
  }
}