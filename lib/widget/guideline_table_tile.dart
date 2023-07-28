import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landconverter/style/style.dart';

class GuidelineTableTile extends StatelessWidget {
  final String place, services, toRecieveAmount, language;
  const GuidelineTableTile({super.key, required this.place, required this.services, required this.toRecieveAmount, required this.language});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.0.w, 14.0.h, 12.0.w, 14.0.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0.r),
        color: grey.withOpacity(0.1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Place
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width:72.w,
                child: Text(language == "English" ? "Place" : "स्थान ", style: roboto(black, 14, 0.0, FontWeight.w500))
              ),
              SizedBox(
                width: 218.w,
                child: Text(place)
              ),
            ],
          ),
          Divider(
            color: grey.withOpacity(0.15),
            thickness: 1.sp,
          ),
          //Purbadhaar
          Row(
            children: [
              SizedBox(
                width:72.w,
                child: Text(language == "English" ? "Structure/Facilities" : "पुर्वाधार/सुविधाहरु ", style: roboto(black, 14, 0.0, FontWeight.w500))
              ),
              SizedBox(
                width: 218.w,
                child: Text(services)
              ),
            ],
          ),
          Divider(
            color: grey.withOpacity(0.15),
            thickness: 1.sp,
          ),
          //Kayam Garne Mulya
          Row(
            children: [
              SizedBox(
                width:72.w,
                child: Text(language == "English" ? "Value To Maintain" : "कायम गर्ने मुल्य", style: roboto(black, 14, 0.0, FontWeight.w500))
              ),
              SizedBox(
                width: 218.w,
                child: Text(toRecieveAmount)
              ),
            ],
          ),
        ],
      ),
    );
  }
}