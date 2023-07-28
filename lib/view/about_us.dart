import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landconverter/style/style.dart';
import 'package:landconverter/widget/custom_appbar.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: customAppBar(context, "About Us", true), 
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 130.h,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top:10.0.h, left: 10.w, right: 10.0.w, bottom: 10.0.h),
                padding: EdgeInsets.fromLTRB(12.0.w, 14.0.h, 12.0.w, 14.0.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0.r),
                  color: formBgColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mulyankan".toUpperCase(), style: roboto(black, 16, 0.5, FontWeight.w500),),
                    SizedBox(height: 15.h,),
                    Text("Nepal based application to calculate your Land Valuation as per your requirement with different valuation ratio.", style: roboto(black, 14, 0.2),)
                  ],
                ),
              ),
              const Spacer(),
              //Powered By
              Text("Powered by".toUpperCase(), style: roboto(black, 10, 0, FontWeight.w500),),
              Image.asset(
                "assets/img/tesseRact_logo.jpeg",
                height: 100.h,
                width: 100.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}