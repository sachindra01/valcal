import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landconverter/style/style.dart';

class BulletTile extends StatelessWidget {
  final String text;
  final String? pointType;
  
  const BulletTile({super.key, required this.text, this.pointType});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pointType == null 
        ? Container(
          margin: EdgeInsets.only(top: 4.8.h),
          height: 5.h,
          width: 5.h,
          decoration: BoxDecoration(
            color: grey,
            borderRadius: BorderRadius.circular(100)
          ),
        )
        : SizedBox(
          width: 5.h,
          child: Text(text, style: roboto(black, 14, 0.2),)
        ),
        SizedBox(
          width: 8.w,
        ),
        SizedBox(
          width: 284.w,
          child: Text(text, style: roboto(black, 13, 0.2),)
        ),
      ],
    );
  }
}