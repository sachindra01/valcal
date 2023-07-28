import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landconverter/style/style.dart';

class LandConverterWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final TextEditingController? textController;
  final Function(String)? onChange;
  final String hintText;
  final double? height, width;
  final bool? readonly;
  const LandConverterWidget({super.key, this.textController, this.onChange,  required this.hintText, this.onTap, this.height, this.width, this.readonly, });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 50.0.h,
        width: width ?? 74.0.w,
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
        ),
        decoration: BoxDecoration(
          color: hintText == "More" ? red : white,
          borderRadius: BorderRadius.circular(5.r),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 223, 223, 223),
              offset: const Offset(0, 5),
              blurRadius: 5.r
            )
          ]
        ),
        child: hintText == "More" 
        ? Text(
          hintText, 
          style: roboto(hintText == "More" ? white : lightGrey, 14.0, 0.0),
        )
        : TextFormField(
          readOnly: readonly == true ? true : false,
          controller: textController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
          ],
          onChanged: onChange,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: hintText,
            labelStyle: roboto(const Color.fromARGB(255, 153, 153, 153), 14, 0.0),
          ),
        ),
      ),
    );
  }
}
