import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landconverter/list/data_list.dart';
import 'package:landconverter/services/analytic_services.dart';
import 'package:landconverter/style/style.dart';
import 'package:landconverter/widget/bullet_tile.dart';
import 'package:landconverter/widget/custom_appbar.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  void initState() {
    currentScreenAnalytics();
    super.initState();
  }

  //Analytics
  Future currentScreenAnalytics() async {
    AnalyticsService.analytics.setCurrentScreen(screenName: "terms_and_conditions_page", screenClassOverride: "terms_and_conditions_page");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: customAppBar(context, "Terms and Condition", true), 
      body: SingleChildScrollView(
        child: Container(
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
              // Text("Terms and Conditions".toUpperCase(), style: roboto(black, 16, 0.5, FontWeight.w500),),
              // SizedBox(height: 15.h,),
              SizedBox(
                width: double.infinity,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: termAndConditions.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return BulletTile(text: termAndConditions[index]);
                  }, 
                  separatorBuilder: (context, idx)=>SizedBox(height: 10.h,),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}