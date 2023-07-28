// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landconverter/list/data_list.dart';
import 'package:landconverter/services/analytic_services.dart';
import 'package:landconverter/services/connectivity.dart';
import 'package:landconverter/style/style.dart';
import 'package:landconverter/view/about_us.dart';
import 'package:landconverter/view/check_land_eligibility.dart';
import 'package:landconverter/view/guidelines_page.dart';
import 'package:landconverter/view/terms_conditions.dart';
import 'package:landconverter/view/valuation_calculator.dart';
import 'package:landconverter/widget/custom_appbar.dart';
import 'package:landconverter/widget/custom_button.dart';
import 'package:landconverter/widget/custom_dialogbox.dart';
import 'package:landconverter/widget/land_conv_textfield.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  //text controllers
  final TextEditingController ropaniController =  TextEditingController();
  final TextEditingController annaController =  TextEditingController();
  final TextEditingController paisaController =  TextEditingController();
  final TextEditingController dhurController =  TextEditingController();
  final TextEditingController daamController =  TextEditingController();
  final TextEditingController kathaController =  TextEditingController();
  final TextEditingController bighaController =  TextEditingController();
  final TextEditingController sqMeterController = TextEditingController();
  final TextEditingController sqFeetController = TextEditingController();

  double ropaniValue = 0.0;
  double aanaValue = 0.0; 
  double paisaValue = 0.0;
  double damValue = 0.0;
  double bighaValue = 0.0; 
  double katthaValue = 0.0;
  double dhurValue = 0.0;
  double sqFeetValue = 0.0;
  double sqMeterValue = 0.0;

  //For Checking Network
  late bool isOnline;

  @override
  void initState() {
    inAppupdate();
    currentScreenAnalytics();
    super.initState();
  }

  @override
  void dispose() {
    ropaniController.dispose();
    annaController.dispose();
    paisaController.dispose();
    daamController.dispose();
    bighaController.dispose();
    kathaController.dispose();
    dhurController.dispose();
    sqMeterController.dispose();
    sqFeetController.dispose();
    super.dispose();
  }

  //Analytics
  Future currentScreenAnalytics() async {
    AnalyticsService.analytics.setCurrentScreen(screenName: "home_screen", screenClassOverride: "home_screen");
  }

  //showing update alert of app if Newversion released.
  inAppupdate(){
    final newVersion = NewVersionPlus(
      iOSId: 'com.app.mulyankan',
      androidId: 'com.app.mulyankan',
    );

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
    const simpleBehavior = false;

    if (simpleBehavior==true) {
      basicStatusCheck(newVersion);
    } else {
      advancedStatusCheck(newVersion);
    }
  }

    basicStatusCheck(NewVersionPlus newVersion) {
      newVersion.showAlertIfNecessary(context: context);
    }

    advancedStatusCheck(NewVersionPlus newVersion) async {
      dynamic status = await newVersion.getVersionStatus();
        log(status.toString());
      if (status != null) {
        log(status.releaseNotes.toString());
        log(status.appStoreLink.toString());
        log(status.localVersion.toString());
        log(status.storeVersion.toString());
        log(status.canUpdate.toString());
        if(status.storeVersion.toString()!=status.localVersion.toString()){
          newVersion.showUpdateDialog(
            context: context,
            versionStatus: status,
            dialogTitle: 'New Version Available!',
            dialogText: 'Do you want to update?',
          );

        }
      }

    }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async => await onBackPress(context),
      child: Scaffold(
        appBar: customAppBar(
          context, 
          "MULYANKAN", 
          false,
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const AboutUs()));
            },
            child: const Padding(
              padding: EdgeInsets.only(right : 12.0, bottom: 4.0),
              child: Icon(Icons.info, color: black, size: 26,),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                //Dashboard
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Check Eligibility
                    CustomButton( 
                      height: 99.w,
                      width: 99.w,
                      buttonRadius: 8.r,
                      buttonContent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h,),
                          Row(
                            children: const [
                              Spacer(),
                              Icon(Icons.check_circle, color: white, size: 32,),
                            ],
                          ),
                          const Spacer(),
                          Text("Check Eligibility", style: roboto(white, 13, 0.2),),
                          SizedBox(height: 10.h,)
                        ],
                      ),
                      text: "",
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const CheckLandEligibility()));
                      }, 
                      buttonBgColor: violet,
                      fontColor: white
                    ),
                    //Valuation Calculator
                    CustomButton(
                      height: 99.w,
                      width: 99.w,
                      buttonRadius: 8.r,
                      buttonContent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h,),
                          Row(
                            children: const [
                              Spacer(),
                              Icon(Icons.calculate, color: white, size: 32,),
                            ],
                          ),
                          const Spacer(),
                          Text("Valuation Calculator", style: roboto(white, 13, 0.2),),
                          SizedBox(height: 10.h,)
                        ],
                      ),
                      text: "", 
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const ValuationCalculator()));
                      }, 
                      buttonBgColor: violet,
                      fontColor: white
                    ),
                    //Guidelines
                    CustomButton( 
                      height: 99.w,
                      width: 99.w,
                      buttonRadius: 8.r,
                      buttonContent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h,),
                          Row(
                            children: const [
                              Spacer(),
                              Icon(Icons.help_center_rounded, color: white, size: 32,),
                            ],
                          ),
                          const Spacer(),
                          Text("\nGuideLine", style: roboto(white, 13, 0.2),),
                          SizedBox(height: 10.h,)
                        ],
                      ),
                      text: "", 
                      onPressed: () async{
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
                      buttonBgColor: violet,
                      fontColor: white
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Building Norms
                    CustomButton( 
                      height: 99.w,
                      width: 99.w,
                      buttonRadius: 8.r,
                      buttonContent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h,),
                          Row(
                            children: const [
                              Spacer(),
                              Icon(Icons.newspaper, color: white, size: 32,),
                            ],
                          ),
                          const Spacer(),
                          Text("Building Norms", style: roboto(white, 13, 0.2),),
                          SizedBox(height: 10.h,)
                        ],
                      ),
                      text: "",
                      onPressed:() async{
                        var networkStatus = await checkInitialConnectivity();
                        if(networkStatus == true){
                          launchUrl(Uri.parse("https://www.dolma.gov.np/office/dept/content/fiscal-year-2079-080-1659243606?fbclid=IwAR3Ar-ZtAhUIPGUlNZVrIGyJYwRi1vrJdK1-7mWcKvRN9H1HY4EHZG3vXLM"),
                            mode: LaunchMode.externalApplication);
                        } else{
                          customDialogBox(
                            context, 
                            "Please Check Your Internet Connection.", 
                            (){},//onYes
                            (){},//onNO
                            (){
                              Navigator.pop(context);
                            }
                          );
                        }
                      },
                      buttonBgColor: Colors.deepOrange,
                      fontColor: white
                    ),
                    //Rate Us
                    CustomButton( 
                      height: 99.w,
                      width: 99.w,
                      buttonRadius: 8.r,
                      buttonContent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h,),
                          Row(
                            children: const [
                              Spacer(),
                              Icon(Icons.thumb_up, color: white, size: 32,),
                            ],
                          ),
                          const Spacer(),
                          Text("\nRate Us", style: roboto(white, 13, 0.2),),
                          SizedBox(height: 10.h,)
                        ],
                      ),
                      text: "",
                      onPressed: (){
                        //app id
                        launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.app.mulyankan'),
                          mode: LaunchMode.externalApplication
                        );
                      }, 
                      buttonBgColor: Colors.redAccent,
                      fontColor: white
                    ),
                    //Terms and Condition
                    CustomButton( 
                      height: 99.w,
                      width: 99.w,
                      buttonRadius: 8.r,
                      buttonContent: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h,),
                          Row(
                            children: const [
                              Spacer(),
                              Icon(Icons.handshake, color: white, size: 32,),
                            ],
                          ),
                          const Spacer(),
                          Text("Terms and Conditions", style: roboto(white, 13, 0.2),),
                          SizedBox(height: 10.h,)
                        ],
                      ),
                      text: "",
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){return const TermsAndConditions();}));
                      }, 
                      buttonBgColor: violet,
                      fontColor: white
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                //Ad Section
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(4.r),
                //   child: Container(
                //     height: 150.h,
                //     width: double.infinity,
                //     color: Colors.blue.withOpacity(0.5),
                //     child: Center(child: Text("Advertisement", style: roboto(black, 16, 0.0),)),
                //   ),
                // ),
                SizedBox(height: 20.h,),
                landConverter(),
                SizedBox(height: 25.h,),
                
              ],
            ),
          ),
        ),
      ),
    );
  } 

    Future onBackPress(context) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Do you want to exit?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => {Navigator.pop(context, false)},
            ),
            TextButton(
                onPressed: () => {Navigator.pop(context, true)},
                child: const Text('Exit'))
          ],
        )
      );
    }
  //land converter
  landConverter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("LAND CONVERTER", style: roboto(black, 16.0, 0.0),),
            const Spacer(),
            GestureDetector(
              onTap: (){
                ropaniController.clear();
                annaController.clear();
                paisaController.clear();
                daamController.clear();
                bighaController.clear();
                kathaController.clear();
                dhurController.clear();
                sqFeetController.clear();
                sqMeterController.clear();
              },
              child: SizedBox(
                width: 40.w,
                height: 25.h,
                child: Center(
                  child: Text("Reset", style: roboto(violet, 14, 0.0),)
                )
              ),
            )
          ],
        ),
        SizedBox(
          height: 15.0.h,
        ),
        Text("Ropani", style: roboto(black, 14.0, 0.0),),
        SizedBox(
          height: 8.0.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LandConverterWidget(
              hintText: data1[0],
              textController: ropaniController,
              onChange: (val) {
                //to set 0 when ntg is inserted
                setZero();
                setState(() {
                  ropaniValue = val == "" ? 0.0 : double.parse(val);
                  //add all value to convert in ropani
                  final ropani = ropaniValue+ aanaValue+ paisaValue+ damValue;
                  //convert to bigha from ropani
                  final bigha = ropani * 0.075116598079561;
                  var convertBigha = bigha.toString().split('.');
                  bighaController.text = convertBigha[0].toString();
                  var katthavalue = '0.${convertBigha[1]}';
                  // coverting biggha to katha 
                  var convertedkathhavalue = double.parse(katthavalue)*20;
                  var dhurvalue =convertedkathhavalue.toString().split('.');
                  kathaController.text = dhurvalue[0].toString();
                  var dhurvalue2 = '0.${dhurvalue[1]}';
                  // converting kattha to dhur
                  var dhurvalue1= double.parse(dhurvalue2)*20;
                  dhurController.text = dhurvalue1.toStringAsFixed(2);
                  //converting kattha to sqaure meter
                  sqMeterController.text = (ropani * 508.74).toStringAsFixed(2);
                  //converting kattha to square feet
                  sqFeetController.text = (ropani * 5476).toStringAsFixed(2);
                });
              },
            ),
            LandConverterWidget(
              hintText: data1[1],
              textController: annaController,
              onChange: (val) {
                setZero();
                setState(() {
                  final annaVal = val == "" ? 0.0 : double.parse(annaController.text);
                  //convert anna to ropani
                  aanaValue = annaVal / 16;
                  //add all value to convert in ropani
                  final anna = ropaniValue+ aanaValue+ paisaValue+ damValue;
                  //convert to bigha from ropani
                  final bigha = anna * 0.075116598079561;
                  var convertBigha = bigha.toString().split('.');
                  bighaController.text = convertBigha[0].toString();
                  var katthavalue = '0.${convertBigha[1]}';
                  // coverting biggha to katha
                  var convertedkathhavalue = double.parse(katthavalue)*20;
                  var dhurvalue =convertedkathhavalue.toString().split('.');
                  kathaController.text = dhurvalue[0].toString();
                  var dhurvalue2 = '0.${dhurvalue[1]}';
                  // converting kattha to dhur
                  var dhurvalue1= double.parse(dhurvalue2)*20;
                  dhurController.text = dhurvalue1.toStringAsFixed(2);
                  //anna to sqm and sqf
                  sqMeterController.text = (anna * 508.74).toStringAsFixed(2);
                  sqFeetController.text = (anna * 5476).toStringAsFixed(2);
                });
              },
            ),
            LandConverterWidget(
              hintText: data1[2],
              textController: paisaController,
              onChange: (val){
                setZero();
                setState(() {
                  final paisaVal = val == "" ? 0.0 : double.parse(val);
                  //paisa to ropani
                  paisaValue = paisaVal / 64;
                  //add all value to convert in ropani
                  final paisa = ropaniValue+ aanaValue+ paisaValue+ damValue;
                  //convert to bigha from ropani
                  final bigha = paisa * 0.075116598079561;
                  var convertBigha = bigha.toString().split('.');
                  bighaController.text = convertBigha[0].toString();
                  var katthavalue = '0.${convertBigha[1]}';
                  // coverting biggha to katha
                  var convertedkathhavalue = double.parse(katthavalue)*20;
                  var dhurvalue =convertedkathhavalue.toString().split('.');
                  kathaController.text = dhurvalue[0].toString();
                  var dhurvalue2 = '0.${dhurvalue[1]}';
                  // converting kattha to dhur
                  var dhurvalue1= double.parse(dhurvalue2)*20;
                  dhurController.text = dhurvalue1.toStringAsFixed(2);
                  //paisa to sqm and sqf
                  sqMeterController.text = (paisa * 508.74).toStringAsFixed(2);
                  sqFeetController.text = (paisa * 5476).toStringAsFixed(2);
                });
              },
            ),
            LandConverterWidget(
              hintText: data1[3],
              textController: daamController,
              onChange: (val){
                setZero();
                setState(() {
                  final damVal = val == "" ? 0.0 : double.parse(val);
                  //dam to ropani
                  damValue = damVal / 256;
                  //add all value to convert in ropani
                  final daam = ropaniValue+ aanaValue+ paisaValue+ damValue;
                  //convert to bigha from ropani
                  final bigha = daam * 0.075116598079561;
                  var bighasplit = bigha.toString().split('.');
                  bighaController.text = bighasplit[0].toString();
                  var katha = "0.${bighasplit[1]}";
                  //bigha to katha
                  var newkathaValue = double.parse(katha)*20;
                  var katthavalue1 = newkathaValue.toString().split('.');
                  kathaController.text = katthavalue1[0].toString();
                  var dhurvalue = "0.${katthavalue1[1]}";
                  //katha to dhur
                  var dhurValue = double.parse(dhurvalue)*20;
                  dhurController.text = dhurValue.toStringAsFixed(2);
                  //dam to sqm and sqf
                  sqMeterController.text = (daam * 508.74).toStringAsFixed(2);
                  sqFeetController.text = (daam * 5476).toStringAsFixed(2);
                });
              },
            ),
          ],
        ),
        SizedBox(height: 15.0.h,),
        Text("Bigha", style: roboto(black, 14.0, 0.0),),
        SizedBox(
          height: 8.0.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LandConverterWidget(  
              hintText: data2[0],
              width: 102.5.w,
              textController: bighaController,
              onChange: (val){
                setZero();
                setState(() {
                  bighaValue = val == "" ? 0.0 : double.parse(val);
                  //add all value in bigha
                  final bigha = bighaValue + katthaValue + dhurValue;
                  //converted biggha to ropani
                  final ropani = bigha * 13.31;
                  var ropanitoAnna = ropani.toString().split('.');
                  ropaniController.text = ropanitoAnna[0].toString();
                  var ropanainewvalue =  "0.${ropanitoAnna[1]}";
                  //converted ropani to anna
                  var annacoverted = double.parse(ropanainewvalue)*16;
                  var originalannavalue = annacoverted.toString().split('.');
                  annaController.text = originalannavalue[0].toString();
                  var paisa =  "0.${originalannavalue[1]}";
                  //converted anna to paisa
                  var paisacoverted = double.parse(paisa)*4;
                  var originalpaisavalue = paisacoverted.toString().split('.');
                  paisaController.text = originalpaisavalue[0].toString();
                  var dam =  "0.${originalpaisavalue[1]}";
                  //converted paisa to dam
                  var damcoverted = double.parse(dam)*4;
                  daamController.text = damcoverted.toStringAsFixed(2);
                  //bigha to sqm and sqf
                  sqMeterController.text = (bigha * 6772.63).toStringAsFixed(2);
                  sqFeetController.text = (bigha * 72900).toStringAsFixed(2);
                });
              },
            ),
            SizedBox(width: 10.w,),
            LandConverterWidget(
              hintText: data2[1],
              width: 102.5.w,
              textController: kathaController,
              onChange: (val){
                setZero();
                setState(() {
                  final kathaVal = val == "" ? 0.0 : double.parse(val);
                  //convert katha to bigha
                  katthaValue = kathaVal / 20;
                  //add all value in bigha
                  final katha = katthaValue + bighaValue + dhurValue;
                  //bigha to ropani
                  final ropani = katha * 13.31;
                  var ropanitoAnna = ropani.toStringAsFixed(2).split('.');
                  ropaniController.text = ropanitoAnna[0].toString();
                  var ropanainewvalue =  "0.${ropanitoAnna[1]}";
                  //ropani to anna
                  var annacoverted = double.parse(ropanainewvalue)*16;
                  var originalannavalue = annacoverted.toString().split('.');
                  annaController.text = originalannavalue[0].toString();
                  var paisa =  "0.${originalannavalue[1]}";
                  //anna to paisa
                  var paisacoverted = double.parse(paisa)*4;
                  var originalpaisavalue = paisacoverted.toString().split('.');
                  paisaController.text = originalpaisavalue[0].toString();
                  var dam =  "0.${originalpaisavalue[1]}";
                  //paisa to dam
                  var damcoverted = double.parse(dam)*4;
                  daamController.text = damcoverted.toStringAsFixed(2);
                  //katha to sqm and sqf
                  sqMeterController.text = (katha * 6772.63).toStringAsFixed(2);
                  sqFeetController.text = (katha * 72900).toStringAsFixed(2);
                });
              },
            ),
            SizedBox(width: 10.w,),
            LandConverterWidget(
              hintText: data2[2],
              width: 102.5.w,
              textController: dhurController,
              onChange: (val){
                setZero();
                setState(() {
                  final dhurVal = val == "" ? 0.0 : double.parse(val);
                  //dhur to bigha
                  dhurValue = dhurVal / 400;
                  //add all in value in bigha
                  final dhur = katthaValue + bighaValue + dhurValue;
                  //bigha to ropani
                  final ropani = dhur * 13.31;
                  var ropanitoAnna = ropani.toString().split('.');
                  ropaniController.text = ropanitoAnna[0].toString();
                  var ropanainewvalue =  "0.${ropanitoAnna[1]}";
                  //converted ropani to anna
                  var annacoverted = double.parse(ropanainewvalue)*16;
                  var originalannavalue = annacoverted.toString().split('.');
                  annaController.text = originalannavalue[0].toString();
                  var paisa =  "0.${originalannavalue[1]}";
                  //converted anna to paisa
                  var paisacoverted = double.parse(paisa)*4;
                  var originalpaisavalue = paisacoverted.toString().split('.');
                  paisaController.text = originalpaisavalue[0].toString();
                  var dam =  "0.${originalpaisavalue[1]}";
                  //converted paisa to dam
                  var damcoverted = double.parse(dam)*4;
                  daamController.text = damcoverted.toStringAsFixed(2);
                  //dhur to sqm and sqf
                  sqMeterController.text = (dhur * 6772.63).toStringAsFixed(2);
                  sqFeetController.text = (dhur * 72900).toStringAsFixed(2);
                });
              },
            ),
          ],
        ),
        SizedBox(height: 15.0.h,),
        Text("Feet/Meter", style: roboto(black, 14.0, 0.0),),
        SizedBox(
          height: 8.0.h,
        ),
        Row(
          children: [
            LandConverterWidget(  
              width: 159.5.w,
              hintText: "Sq. ft.",
              textController: sqFeetController,
              onChange: (val){
                setZero();
                setState(() {
                  sqFeetValue = val == "" ? 0.0 : double.parse(val);
                  //converting sqfeet to sqm
                  sqMeterController.text = (sqFeetValue / 10.76).toStringAsFixed(2);
                  //converted sqf to ropani
                  final ropani = sqFeetValue / 5476;
                  var ropanitoAnna = ropani.toString().split('.');
                  ropaniController.text = ropanitoAnna[0].toString();
                  var ropanainewvalue =  "0.${ropanitoAnna[1]}";
                  //converted ropani to anna
                  var annacoverted = double.parse(ropanainewvalue)*16;
                  var originalannavalue = annacoverted.toString().split('.');
                  annaController.text = originalannavalue[0].toString();
                  var paisa =  "0.${originalannavalue[1]}";
                   //converted anna to paisa
                  var paisacoverted = double.parse(paisa)*4;
                  var originalpaisavalue = paisacoverted.toString().split('.');
                  paisaController.text = originalpaisavalue[0].toString();
                  var dam =  "0.${originalpaisavalue[1]}";
                  //converted paisa to dam
                  var damcoverted = double.parse(dam)*4;
                  daamController.text = damcoverted.toStringAsFixed(2);
                  //convert sqf to bigha
                  final bigha = sqFeetValue / 72900;
                  var convertBigha = bigha.toString().split('.');
                  bighaController.text = convertBigha[0].toString();
                  var katthavalue = '0.${convertBigha[1]}';
                  // coverting biggha to katha
                  var convertedkathhavalue = double.parse(katthavalue)*20;
                  var dhurvalue =convertedkathhavalue.toString().split('.');
                  kathaController.text = dhurvalue[0].toString();
                  var dhurvalue2 = '0.${dhurvalue[1]}';
                  // converting kattha to dhur
                  var dhurvalue1= double.parse(dhurvalue2)*20;
                  dhurController.text = dhurvalue1.toStringAsFixed(2);
                });
              },
            ),
            SizedBox(width: 10.w,),
            LandConverterWidget(  
              width: 159.5.w,
              hintText: "Sq. m.",
              textController: sqMeterController,
              onChange: (val){
                setZero();
                setState(() {
                  sqMeterValue = val == "" ? 0.0 : double.parse(val);
                  //converting sqm to sqfeet
                  sqFeetController.text = (sqMeterValue * 10.76).toStringAsFixed(2);
                  //converted sqm to ropani
                  final ropani = sqMeterValue / 508.74;
                  var ropanitoAnna = ropani.toString().split('.');
                  ropaniController.text = ropanitoAnna[0].toString();
                  var ropanainewvalue =  "0.${ropanitoAnna[1]}";
                  //converted ropani to anna
                  var annacoverted = double.parse(ropanainewvalue)*16;
                  var originalannavalue = annacoverted.toString().split('.');
                  annaController.text = originalannavalue[0].toString();
                  var paisa =  "0.${originalannavalue[1]}";
                  //converted anna to paisa
                  var paisacoverted = double.parse(paisa)*4;
                  var originalpaisavalue = paisacoverted.toString().split('.');
                  paisaController.text = originalpaisavalue[0].toString();
                  var dam =  "0.${originalpaisavalue[1]}";
                  //converted paisa to dam
                  var damcoverted = double.parse(dam)*4;
                  daamController.text = damcoverted.toStringAsFixed(2); 
                  //convert sqm to bigha
                  final bigha = sqMeterValue / 6772.63;
                  var convertBigha = bigha.toString().split('.');
                  bighaController.text = convertBigha[0].toString();
                  var katthavalue = '0.${convertBigha[1]}';
                  // coverting biggha to katha
                  var convertedkathhavalue = double.parse(katthavalue)*20;
                  var dhurvalue =convertedkathhavalue.toString().split('.');
                  kathaController.text = dhurvalue[0].toString();
                  var dhurvalue2 = '0.${dhurvalue[1]}';
                  // converting kattha to dhur
                  var dhurvalue1= double.parse(dhurvalue2)*20;
                  dhurController.text = dhurvalue1.toStringAsFixed(2);
                });
              },
            ),
          ],
        ),
      ],
    );
  }
  
  //set 0 when land converter txtfield is made empty
  setZero() {
    setState(() {
      if(ropaniController.text == ""){
        ropaniValue =0;
      }
      if(annaController.text == ""){
        aanaValue = 0;
      }
      if(paisaController.text == ""){
        paisaValue = 0;
      }
      if(daamController.text == ""){
        damValue = 0;
      }
      if(bighaController.text == ""){
        bighaValue = 0;
      }
      if(kathaController.text == ""){
        katthaValue = 0;
      }
      if(dhurController.text == ""){
        dhurValue = 0;
      }
      if(sqFeetController.text == ""){
        sqFeetValue =0;
      }
      if(sqMeterController.text == ""){
        sqMeterValue = 0;
      }
    });
  }
}
