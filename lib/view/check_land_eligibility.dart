// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landconverter/services/analytic_services.dart';
import 'package:landconverter/services/connectivity.dart';
import 'package:landconverter/style/style.dart';
import 'package:landconverter/view/guidelines_page.dart';
import 'package:landconverter/widget/custom_appbar.dart';
import 'package:landconverter/widget/custom_button.dart';
import 'package:landconverter/widget/custom_dialogbox.dart';
import 'package:landconverter/widget/custom_textfield.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_utils/nepali_utils.dart';

class CheckLandEligibility extends StatefulWidget {
  const CheckLandEligibility({super.key});

  @override
  State<CheckLandEligibility> createState() => _CheckLandEligibilityState();
}

class _CheckLandEligibilityState extends State<CheckLandEligibility> {
  //check Calculation Status
  bool isCalculated = false;

  //Bool Check for owner type
  bool isSingleOwner = true;
  bool isMohiVayeko = false;
  bool isGuthi = false;

  //for Single Owner
  bool isRajinama = true;
  bool isRajinamaEligible = false;
  bool isBakaspatra = false;
  bool isBakaspatraEligible = false;
  bool isAnsabanda = false;
  bool isAnsabandaEligible = false;

  //For Date Picking
  final DateTime initialDate = DateTime.now();
  final dateConEng =  TextEditingController();
  final dateConNep = TextEditingController();

  //For Date and Time calculation
  var pickedDateInMilliseconds = 0;
  var todaysDateInMilliseconds = DateTime.now().millisecondsSinceEpoch;
  var threeMonths = 7889400000;
  var sixMonth35InMilliseconds = 18802476000;
  var twoYrs35DaysInMillisecond = 66137904000;
  late int ansabandaTimeInMilliseconds;
  late int bakaspatraTimeInMilliseconds;
  late int rajinamaTimeInMilliseconds;

  @override
  void initState() {
    currentScreenAnalytics();
    ansabandaTimeInMilliseconds = (todaysDateInMilliseconds - threeMonths);
    bakaspatraTimeInMilliseconds = (todaysDateInMilliseconds - twoYrs35DaysInMillisecond);
    rajinamaTimeInMilliseconds = (todaysDateInMilliseconds - sixMonth35InMilliseconds);
    super.initState();
  }
  
  //Analytics
  Future currentScreenAnalytics() async {
    AnalyticsService.analytics.setCurrentScreen(screenName: "check_land_eligibility", screenClassOverride: "check_land_eligibility");
  }

  @override
  void dispose() {
    dateConEng.dispose();
    dateConNep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: customAppBar(context,"Check Land Eligibility", true),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                //Select Owernship Container
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top:10.0.h, left: 10.w, right: 10.0.w, bottom: 0.0.h),
                  padding: EdgeInsets.fromLTRB(12.0.w, 22.0.h, 12.0.w, 14.0.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0.r),
                    color: formBgColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Select Ownership Type
                      selectLandOwnerShipType(),
                    ],
                  ),
                ),
                //Selected wise Container
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top:10.0.h, left: 10.w, right: 10.0.w, bottom: 0.0.h),
                  padding: EdgeInsets.symmetric(horizontal :12.0.w, vertical: 14.0.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0.r),
                    color: formBgColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Content
                      isSingleOwner ? 
                      singleOwner()
                      : isMohiVayeko ? 
                       mohiVayeko()
                      : guthi(),
                    ],
                  ),
                ),
                //Result
                result(),
                SizedBox(height: 80.h,),
              ],
            ),
          ),
          //Submit Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: formBgColor,
              padding: EdgeInsets.all(12.sp),
              child: CustomButton(
                text: "Submit".toUpperCase(), 
                onPressed: (){
                  checkEligibility();
                }, 
                buttonBgColor: buttonbgColor, 
                fontColor: white,
                buttonRadius: 4.r,
                textStyle: roboto(white, 17.0, 0.2, FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }

  //Select Land OwnerShip Type
  selectLandOwnerShipType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Check Land Eligibility'.toUpperCase(), style: roboto(darkBlack, 16.0, 0.0,FontWeight.w400),),
        SizedBox(height: 15.0.h,),
        Row(
          children: [
            //Single Owner
            Checkbox(
              activeColor: violet.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0.r),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(width: 1.5, color: lightGrey),
              ),
              value: isSingleOwner,
              onChanged:  isSingleOwner == false ?
              (val){ 
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {
                    isSingleOwner = !isSingleOwner;
                    isMohiVayeko = false;
                    isGuthi = false;
                });
              } : (val){ FocusManager.instance.primaryFocus?.unfocus();},
            ),
            Text("Single Owner (एकल स्वामित्व)", style: roboto(black, 15, 0.0),),
          ],
        ),
        //Mohi Vayeko
        Row(
          children: [
            Checkbox(
              activeColor: violet.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0.r),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(width: 1.5, color: lightGrey),
              ),
              value: isMohiVayeko,
              onChanged: isMohiVayeko == false ?
              (val){ 
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {
                    isSingleOwner = false;
                    isMohiVayeko = !isMohiVayeko;
                    isGuthi = false;
                });
              } : (val){ FocusManager.instance.primaryFocus?.unfocus();},
            ),
            Text("Mohi Vayeko (मोही भएको)", style: roboto(black, 15, 0.0),),
          ],
        ),
        //Guthi
        Row(
          children: [
            Checkbox(
              activeColor: violet.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0.r),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(width: 1.5, color: lightGrey),
              ),
              value: isGuthi,
              onChanged: isGuthi == false ?
              (val){ 
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {
                    isSingleOwner = false;
                    isMohiVayeko = false;
                    isGuthi = !isGuthi;
                });
              } : (val){ FocusManager.instance.primaryFocus?.unfocus();},
            ),
            Text("Guthi (गुठी)", style: roboto(black, 15, 0.0),),
          ],
        ),
      ],
    );
  }

  //Single Owner
  singleOwner(){
    return Column(
      children: [
        Row(
          children: [
            Text("Land Transfer Method".toUpperCase(),style: roboto(black, 16, 0.0),),
            const Spacer(),
            InkWell(
              onTap: () async{
                var networkStatus = await checkInitialConnectivity();
                if(networkStatus == true){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const GuidelinesPage();
                  }));
                } else{
                  customDialogBox(
                    context, 
                    "Please Check Your Internet Connection.", 
                    (){}, 
                    (){},
                    (){
                      Navigator.pop(context);
                    }
                  );
                }
              }, 
              child: Row(
                children: [
                  Text("Guidlines".toUpperCase(),style: roboto(violet, 13, 0.0),),
                  SizedBox(width: 4.w,),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: violet,),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 15.0.h,),
        //Rajinama
        Row(
          children: [
            Checkbox(
              activeColor: violet.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0.r),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(width: 1.5, color: lightGrey),
              ),
              value: isRajinama,
              onChanged: isRajinama == false ?
              (val){ 
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {
                    isRajinama = !isRajinama;
                    isBakaspatra = false;
                    isAnsabanda = false;
                    isCalculated = false;
                });
              } : (val){ FocusManager.instance.primaryFocus?.unfocus();},
            ),
            Row(
              children: [
                Text("Rajinama (राजिनामा)", style: roboto(black, 15, 0.0),),
                SizedBox(width: 5.0.w,),
                Text("6m 35d", style: roboto(violet, 15, 0.0),),
              ],
            ),
          ],
        ),
        //Bakashpatra
        Row(
          children: [
            Checkbox(
              activeColor: violet.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0.r),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(width: 1.5, color: lightGrey),
              ),
              value: isBakaspatra,
              onChanged: isBakaspatra == false ?
              (val){ 
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {
                    isRajinama = false;
                    isBakaspatra = !isBakaspatra;
                    isAnsabanda = false;
                    isCalculated = false;
                });
              } : (val){ FocusManager.instance.primaryFocus?.unfocus();},
            ),
            Row(
              children: [
                Text("Bakaspatra (बकसपत्र)", style: roboto(black, 15, 0.0),),
                SizedBox(width: 5.0.w,),
                Text("2yrs 35days", style: roboto(violet, 15, 0.0),),
              ],
            ),
          ],
        ),
        //Bakashpatra
        Row(
          children: [
            Checkbox(
              activeColor: violet.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0.r),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(width: 1.5, color: lightGrey),
              ),
              value: isAnsabanda,
              onChanged: isAnsabanda == false ?
              (val){ 
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {
                    isRajinama = false;
                    isBakaspatra = false;
                    isAnsabanda = !isAnsabanda;
                    isCalculated = false;
                });
              } : (val){ FocusManager.instance.primaryFocus?.unfocus();},
            ),
            Row(
              children: [
                Text("Ansabanda (अंशबण्डा)", style: roboto(black, 15, 0.0),),
                SizedBox(width: 5.0.w,),
                Text("3m", style: roboto(violet, 15, 0.0),),
              ],
            ),
          ],
        ),
        SizedBox(height: 15.0.h,),
        //Select Nepali Date
        CustomTextField(
          textController: dateConNep,
          labelText: "Select Date (Nepali)",
          readOnly: true,
          ontap: (){
            pickDateNep();
          }
        ),
        SizedBox(height: 8.h,),
        CustomTextField(
          textController: dateConEng,
          labelText: "Select Date (English)",
          readOnly: true,
          ontap: () {
            pickDateEng();
          },
        ),
      ],
    );
  }

  //Mohi Vayeko
  mohiVayeko(){
    return Column(
      children: [
        Center(child: Text("Mohi Vayeko Not Eligible", style: roboto(red, 18.0, 0.1)))
      ],
    );
  }

  //Guthi
  guthi(){
    return Column(
      children: [
        Center(child: Text("Guthi Not Eligible ",style: roboto(red, 18.0, 0.1))),
      ],
    );
  }

  //Date Picker Nepali
  pickDateNep() async{
    DateTime? pickedDate = await picker.showMaterialDatePicker(
      context: context,
      initialDate: NepaliDateTime.now(),
      firstDate: NepaliDateTime(2000),
      lastDate: NepaliDateTime(2090),
      initialDatePickerMode: DatePickerMode.day,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: violet.withOpacity(0.9), //Background color
              onPrimary: white, //Selected Date Font Color
              onSurface: grey, //UnSelected Date Font Color
            ),
          ),
          child: child!,
        );
      },
    );
    //Formatt date
    var formattedDateTime = DateTime(pickedDate!.year, pickedDate.month, pickedDate.day).toString();
    var engDate = NepaliDateTime(pickedDate.year, pickedDate.month, pickedDate.day, 0, 0, 0).toDateTime();
    dateConNep.text = DateFormat('yyyy/MM/dd').format((DateTime.parse(formattedDateTime))).toString();
    dateConEng.text = DateFormat('MM/dd/yyyy').format((DateTime.parse(engDate.toString()))).toString();
    pickedDateInMilliseconds = engDate.millisecondsSinceEpoch;
    if(isCalculated){
      checkEligibility();
    }
    setState(() {});
  }

  //Date Picker English
  pickDateEng() async{
    DateTime? pickedDate = await showDatePicker(
      context: context, 
      initialDate: initialDate,
      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(3000),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: violet.withOpacity(0.9), //Background color
              onPrimary: white, //Selected Date Font Color
              onSurface: grey, //UnSelected Date Font Color
            ),
          ),
          child: child!,
        );
      },
    );

    //Formatt date
    var englishDateTime = DateTime(pickedDate!.year, pickedDate.month, pickedDate.day).toString();
    var nepaliDate = DateTime(pickedDate.year, pickedDate.month, pickedDate.day).toNepaliDateTime();
    dateConEng.text = DateFormat('MM/dd/yyyy').format((DateTime.parse(englishDateTime))).toString();
    dateConNep.text = NepaliDateFormat('MM/dd/yyyy').format((NepaliDateTime.parse(nepaliDate.toString()))).toString();
    pickedDateInMilliseconds = pickedDate.millisecondsSinceEpoch;
    if(isCalculated){
      checkEligibility();
    }
    setState(() {});
  }

  //Check Eligibility
  checkEligibility(){
    if(pickedDateInMilliseconds == 0){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 1000),
          backgroundColor: red.withOpacity(0.9),
          dismissDirection: DismissDirection.up,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20.w,
            left: 20.w),
          behavior: SnackBarBehavior.floating,
          content: Text("Date must be selected", style: roboto(white, 14, 0.0),),
        )
      );
      return;
    }
    isCalculated = true;
    if(isRajinama && pickedDateInMilliseconds <= rajinamaTimeInMilliseconds){
      isRajinamaEligible = true;
    } else if(isBakaspatra && pickedDateInMilliseconds <= bakaspatraTimeInMilliseconds){
      isBakaspatraEligible = true;
    } else if(isAnsabanda && pickedDateInMilliseconds <= ansabandaTimeInMilliseconds){
      isAnsabandaEligible = true;
    } else{
      isAnsabandaEligible = false;
      isBakaspatraEligible = false;
      isRajinamaEligible = false;
    }
    setState(() {});
  }

  //Result
  result(){
    if(isSingleOwner && isRajinama && isCalculated){//For Rajinama
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top:10.0.h, left: 10.w, right: 10.0.w, bottom: 0.0.h),
        padding: EdgeInsets.symmetric(horizontal :12.0.w, vertical: 14.0.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0.r),
          color: formBgColor,
        ),
        child: Text(isRajinamaEligible ? "Your land is Eligible" : "Not Eligible", style: roboto(isRajinamaEligible ? green : red, 18.0, 0.0, FontWeight.w500)),
      );
    } else if(isSingleOwner && isBakaspatra && isCalculated){//For Bakaspatra
      return Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top:10.0.h, left: 10.w, right: 10.0.w, bottom: 0.0.h),
        padding: EdgeInsets.symmetric(horizontal :12.0.w, vertical: 14.0.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0.r),
          color: formBgColor,
        ),
        child: Text(isBakaspatraEligible ? "Your land is Eligible" : "Not Eligible", style: roboto(isBakaspatraEligible ? green : red, 18.0, 0.0, FontWeight.w500)),
      );
    } else if(isSingleOwner && isAnsabanda && isCalculated){//For Ansabanda
      return Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top:10.0.h, left: 10.w, right: 10.0.w, bottom: 0.0.h),
        padding: EdgeInsets.symmetric(horizontal :12.0.w, vertical: 14.0.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0.r),
          color: formBgColor,
        ),
        child: Text(isAnsabandaEligible ? "Your land is Eligible" : "Not Eligible", style: roboto(isAnsabandaEligible ? green : red, 18.0, 0.0, FontWeight.w500)),
      );
    } else{//If not calculated
      return const SizedBox();
    }
  }
}