import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landconverter/list/data_list.dart';
import 'package:landconverter/services/analytic_services.dart';
import 'package:landconverter/services/connectivity.dart';
import 'package:landconverter/style/style.dart';
import 'package:landconverter/widget/custom_appbar.dart';
import 'package:landconverter/widget/custom_button.dart';
import 'package:landconverter/widget/custom_dialogbox.dart';
import 'package:landconverter/widget/custom_textfield.dart';
import 'package:landconverter/widget/land_conv_textfield.dart';
import 'package:url_launcher/url_launcher.dart';

class ValuationCalculator extends StatefulWidget {
  const ValuationCalculator({super.key});

  @override
  State<ValuationCalculator> createState() => _ValuationCalculatorState();
}

class _ValuationCalculatorState extends State<ValuationCalculator> {
  //bool check for checkbox
  bool isAnna = true;
  bool isKattha = false;
  bool isSqmeter = false;

  //initial value
  double lalpurjaAanaVlaue = 0.00;
  double siteAanaValue = 0.00;
  double lalpurjaKathaVlaue = 0.00;
  double siteKathaValue = 0.00;
  double lalpurjaSqmVlaue = 0.00;
  double siteSqmValue = 0.00;

//forLalpurja
  double ropaniToAana = 0.00;
  double aana = 0.00;
  double paisaToAana = 0.00; 
  double damToAana = 0.00;
  double bighaToKattha = 0.00;
  double kattha = 0.00;
  double dhurTokattha = 0.00; 
  double sqMeter = 0.00;

  //forSite
  double ropaniToAanaSite = 0.00;
  double aanaSite = 0.00;
  double paisaToAanaSite = 0.00; 
  double damToAanaSite = 0.00;
  double bighaToKatthaSite = 0.00;
  double katthaSite = 0.00;
  double dhurTokatthaSite = 0.00; 
  double sqMeterSite = 0.00;

  //inital Result
  double aanaResult = 0.00;
  double katthaResult = 0.00;
  double sqMeterResult =0.00;

  //initial Rate
  double weighteAvgRate = 0.00;
  double distressValue = 0.00;

  //text controllers lalpurja
  final ropaniController =  TextEditingController();
  final annaController =  TextEditingController();
  final paisaController =  TextEditingController();
  final dhurController =  TextEditingController();
  final daamController =  TextEditingController();
  final kathaController =  TextEditingController();
  final bighaController =  TextEditingController();
  final sqMeterController = TextEditingController();

  //text controllers site
  final ropaniSiteController =  TextEditingController();
  final annaSiteController =  TextEditingController();
  final paisaSiteController =  TextEditingController();
  final dhurSiteController =  TextEditingController();
  final daamSiteController =  TextEditingController();
  final kathaSiteController =  TextEditingController();
  final bighaSiteController =  TextEditingController();
  final sqMeterSiteController = TextEditingController();

  //forValuation
  double ropaniValuation =  0;
  double annaValation =  0;
  double paisaValation =  0;
  double dhurValation =  0;
  double daamValation =  0;
  double kathaValation =  0;
  double bighaValation =  0;
  double sqMeterValation = 0;

  //text controller rate
  final govtRateController =  TextEditingController();
  final commercialRateController = TextEditingController();
  
  //for dropdown textfield
  final dropDownController = TextEditingController();
  final weightedRatioController = TextEditingController();
  final distressRatioController = TextEditingController();

  //scroll controller
  final scrollCon = ScrollController();

  //view results
  bool valuationRate = false;

  //initial item for rate dropdrown
  indexRate(){
    for (int i=0;i<values.length;i++) {
      if (values[i] == dropDownController.text) {
        return i; 
      }
    }
  }
  
  //initial item for rate weighted avg value ratio
  indexWeightedRatio(){
    for (int i=0;i<weightedRatio.length;i++) {
      if (weightedRatio[i] == weightedRatioController.text) {
        return i; 
      }
    }
  }

  //initial item for rate distress ratio
  indexDistressRatio(){
    for (int i=0;i<distressRatio.length;i++) {
      if (distressRatio[i] == distressRatioController.text) {
        return i; 
      }
    }
  }



  @override
  void initState() {
    currentScreenAnalytics();
    initBindTxtFieldVal();
    super.initState();
  }

  Future currentScreenAnalytics() async {
    AnalyticsService.analytics.setCurrentScreen(screenName: "valuation_calculator", screenClassOverride: "valuation_calculator");
  }
  
  initBindTxtFieldVal(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dropDownController.text = "Aana";
      weightedRatioController.text = "70% - 30%";
      distressRatioController.text = "80%";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: customAppBar(context,"Valuation Calculator", true),
      body: SingleChildScrollView(
        controller: scrollCon,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            //Select Unit Container
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
                  //select unit
                  selectUnit(),
                ],
              ),
            ),
            //Calculation Container
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
                  //area as per Lalpurja
                  areaLalpurja(),
                  SizedBox(height: 25.0.h,),
                  Divider(
                    color: grey.withOpacity(0.15),
                    thickness: 1.sp,
                  ),
                  SizedBox(height: 18.0.h,),
                  //area as per Site
                  areaSite(),
                  SizedBox(height: 25.0.h,),
                  Divider(
                    color: grey.withOpacity(0.15),
                    thickness: 1.sp,
                  ),
                  SizedBox(height: 18.0.h,),
                  //consideration area for valuation
                  valuation(),
                  Divider(
                    color: grey.withOpacity(0.15),
                    thickness: 1.sp,
                  ),
                  SizedBox(height: 18.0.h,),
                  result(),
                ],
              ),
            ),
            //rate Container
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top:10.0.h, left: 10.w, right: 10.0.w, bottom: 10.0.h),
              padding: EdgeInsets.fromLTRB(12.0.w, 22.0.h, 12.0.w, 14.0.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0.r),
                color: formBgColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //result
                  rate(),
                  SizedBox(height: 15.0.h,),
                  Divider(
                    color: grey.withOpacity(0.15),
                    thickness: 1.sp,
                  ),
                  //rate calculation button
                  Container(
                    color: formBgColor,
                    padding: EdgeInsets.all(12.sp),
                    child: CustomButton(
                      text: "CALCULATE", 
                      onPressed: (){
                        FocusManager.instance.primaryFocus?.unfocus();
                        rateCalculation();
                      }, 
                      buttonBgColor: buttonbgColor, 
                      fontColor: white,
                      buttonRadius: 4.r,
                      textStyle: roboto(white, 17.0, 0.2, FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //choose unit at top
  selectUnit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Unit'.toUpperCase(), style: roboto(darkBlack, 16.0, 0.0,FontWeight.w400),),
        SizedBox(height: 15.0.h,),
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
              value: isAnna,
              onChanged: isAnna == false ?
              (val) {
                FocusManager.instance.primaryFocus?.unfocus();
                if(aanaResult == 0.00 &&  katthaResult == 0.00 && sqMeterResult == 0.00 
                && weighteAvgRate == 0.00 && distressValue == 0.00
                && bighaController.text == "" && bighaSiteController.text == ""
                && kathaController.text == "" && kathaSiteController.text == ""
                && dhurController.text == "" && dhurSiteController.text == ""
                && sqMeterController.text == "" && sqMeterSiteController.text == ""){
                  setState(() {
                    isAnna = !isAnna;
                    isKattha = false;
                    isSqmeter = false;
                    govtRateController.clear();
                    commercialRateController.clear();
                    valuationRate = false;
                  });
                }
                else{
                  customDialogBox(
                    context, 
                    "CHANGE UNIT? \n\nAll previous data will be lost.", 
                    (){ 
                      setState(() {
                        isAnna = !isAnna;
                        isKattha = false;
                        isSqmeter = false;
                        govtRateController.clear();
                        commercialRateController.clear();
                        bighaController.clear();
                        bighaSiteController.clear();
                        kathaController.clear();
                        kathaSiteController.clear();
                        dhurController.clear();
                        dhurSiteController.clear();
                        sqMeterController.clear();
                        sqMeterSiteController.clear();
                        bighaValation =  0; kathaValation =  0;
                        dhurValation =  0; sqMeterValation = 0;

                        lalpurjaAanaVlaue = 0.00; siteAanaValue = 0.00; lalpurjaKathaVlaue = 0.00;
                        siteKathaValue = 0.00; lalpurjaSqmVlaue = 0.00; siteSqmValue = 0.00;

                        ropaniToAana = 0.00; aana = 0.00; paisaToAana = 0.00; damToAana = 0.00;
                        bighaToKattha = 0.00; kattha = 0.00; dhurTokattha = 0.00;   sqMeter = 0.00;

                        ropaniToAanaSite = 0.00; aanaSite = 0.00; paisaToAanaSite = 0.00;  damToAanaSite = 0.00;
                        bighaToKatthaSite = 0.00;  katthaSite = 0.00; dhurTokatthaSite = 0.00; sqMeterSite = 0.00;
                  
                        aanaResult = 0.00;
                        katthaResult = 0.00;
                        sqMeterResult = 0.00;
                  
                        weighteAvgRate = 0.00;
                        distressValue = 0.00;
                        valuationRate = false;
                      });
                      Navigator.pop(context);
                    }, 
                    (){
                      Navigator.pop(context);
                    }
                  );
                }
              } : (val){ FocusManager.instance.primaryFocus?.unfocus();},
            ),
            Text("Aana", style: roboto(black, 15, 0.0),),
            SizedBox(width: 16.w,),
            Checkbox(
              activeColor: violet.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0.r),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(width: 1.5, color: lightGrey),
              ),
              value: isKattha,
              onChanged: isKattha == false ?
              (val) {
                FocusManager.instance.primaryFocus?.unfocus();
                if(aanaResult == 0.00 &&  katthaResult == 0.00 && sqMeterResult == 0.00 
                && weighteAvgRate == 0.00 && distressValue == 0.00
                && ropaniController.text == "" && ropaniSiteController.text == ""
                && annaController.text == "" && annaSiteController.text == ""
                && paisaController.text == "" && paisaSiteController.text == ""
                && daamController.text == "" && daamSiteController.text == ""
                && sqMeterController.text == "" && sqMeterSiteController.text == ""){
                  setState(() {
                    isKattha = !isKattha;
                    isAnna = false;
                    isSqmeter = false;
                    govtRateController.clear();
                    commercialRateController.clear();
                    valuationRate = false;
                  });
                }
                else{
                  customDialogBox(
                    context, 
                    "CHANGE UNIT? \n\nAll previous data will be lost.", 
                    (){
                      setState(() {
                        isKattha = !isKattha;
                        isAnna = false;
                        isSqmeter = false;
                        govtRateController.clear();
                        commercialRateController.clear();
                        ropaniController.clear();
                        ropaniSiteController.clear();
                        annaController.clear();
                        annaSiteController.clear();
                        paisaController.clear();
                        paisaSiteController.clear();
                        daamController.clear();
                        daamSiteController.clear();
                        sqMeterController.clear();
                        sqMeterSiteController.clear();
                        ropaniValuation =  0;
                        annaValation =  0;
                        paisaValation =  0;
                        daamValation =  0;
                        sqMeterValation = 0;

                        lalpurjaAanaVlaue = 0.00;
                        siteAanaValue = 0.00;
                        lalpurjaKathaVlaue = 0.00;
                        siteKathaValue = 0.00;
                        lalpurjaSqmVlaue = 0.00;
                        siteSqmValue = 0.00;

                        ropaniToAana = 0.00;
                        aana = 0.00;
                        paisaToAana = 0.00; 
                        damToAana = 0.00;
                        bighaToKattha = 0.00;
                        kattha = 0.00;
                        dhurTokattha = 0.00; 
                        sqMeter = 0.00;

                        ropaniToAanaSite = 0.00;
                        aanaSite = 0.00;
                        paisaToAanaSite = 0.00; 
                        damToAanaSite = 0.00;
                        bighaToKatthaSite = 0.00;
                        katthaSite = 0.00;
                        dhurTokatthaSite = 0.00; 
                        sqMeterSite = 0.00;

                        aanaResult = 0.00;
                        katthaResult = 0.00;
                        sqMeterResult =0.00;

                        weighteAvgRate = 0.00;
                        distressValue = 0.00;
                        valuationRate = false;
                      });
                      Navigator.pop(context);
                    }, 
                    (){
                      Navigator.pop(context);
                    }
                  );
                }
                
              }:(val) { FocusManager.instance.primaryFocus?.unfocus();},
            ),
            Text("Kattha", style: roboto(black, 15, 0.0),),
            SizedBox(width: 16.w,),
            Checkbox(
              activeColor: violet.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0.r),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(width: 1.5, color: lightGrey),
              ),
              value: isSqmeter,
              onChanged: isSqmeter == false ?
              (val) {
                FocusManager.instance.primaryFocus?.unfocus();
                if(aanaResult == 0.00 &&  katthaResult == 0.00 && sqMeterResult == 0.00 
                && weighteAvgRate == 0.00 && distressValue == 0.00
                && ropaniController.text == "" && ropaniSiteController.text == ""
                && annaController.text == "" && annaSiteController.text == ""
                && paisaController.text == "" && paisaSiteController.text == ""
                && daamController.text == "" && daamSiteController.text == ""
                && bighaController.text == "" && bighaSiteController.text == ""
                && kathaController.text == "" && kathaSiteController.text == ""
                && dhurController.text == "" && dhurSiteController.text == ""){
                  setState(() {
                    isSqmeter = !isSqmeter;
                    isKattha = false;
                    isAnna = false;
                    govtRateController.clear();
                    commercialRateController.clear();
                  });
                }
                else{
                  customDialogBox(
                    context, 
                    "CHANGE UNIT? \n\nAll previous data will be lost.", 
                    (){
                      setState(() {
                        isSqmeter = !isSqmeter;
                        isKattha = false;
                        isAnna = false;
                        govtRateController.clear();
                        commercialRateController.clear();
                        ropaniController.clear();
                        ropaniSiteController.clear();
                        annaController.clear();
                        annaSiteController.clear();
                        paisaController.clear();
                        paisaSiteController.clear();
                        daamController.clear();
                        daamSiteController.clear();
                        bighaController.clear();
                        bighaSiteController.clear();
                        kathaController.clear();
                        kathaSiteController.clear();
                        dhurController.clear();
                        dhurSiteController.clear();
                        ropaniValuation =  0;
                        annaValation =  0;
                        paisaValation =  0;
                        daamValation =  0;
                        bighaValation =  0;
                        kathaValation =  0;
                        dhurValation =  0;

                        lalpurjaAanaVlaue = 0.00;
                        siteAanaValue = 0.00;
                        lalpurjaKathaVlaue = 0.00;
                        siteKathaValue = 0.00;
                        lalpurjaSqmVlaue = 0.00;
                        siteSqmValue = 0.00;

                        ropaniToAana = 0.00;
                        aana = 0.00;
                        paisaToAana = 0.00; 
                        damToAana = 0.00;
                        bighaToKattha = 0.00;
                        kattha = 0.00;
                        dhurTokattha = 0.00; 
                        sqMeter = 0.00;

                        ropaniToAanaSite = 0.00;
                        aanaSite = 0.00;
                        paisaToAanaSite = 0.00; 
                        damToAanaSite = 0.00;
                        bighaToKatthaSite = 0.00;
                        katthaSite = 0.00;
                        dhurTokatthaSite = 0.00; 
                        sqMeterSite = 0.00;

                        aanaResult = 0.00;
                        katthaResult = 0.00;
                        sqMeterResult =0.00;

                        weighteAvgRate = 0.00;
                        distressValue = 0.00;
                        valuationRate = false;
                      });
                      Navigator.pop(context);
                    }, 
                    (){
                      Navigator.pop(context);
                    }
                  );
                }
              }
              : (val){ FocusManager.instance.primaryFocus?.unfocus();},
            ),
            Text("Sq. m", style: roboto(black, 15, 0.0),),
          ],
        )
      ],
    );
  }

  //area as per lalpurja
  areaLalpurja() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Area as per Lalpurja", style: roboto(darkBlack, 16.0, 0.5,FontWeight.w400),), 
        SizedBox(height: 25.h,),
        isAnna == true ?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LandConverterWidget(
              hintText: 'Ropani',
              textController: ropaniController,
              onChange: (val) {
                setState(() {
                  if(val != ''){
                    final ropani = double.parse(val);
                    // coverting ropani to anna
                    ropaniToAana = ropani * 16;
                  }
                  else{
                    ropaniToAana = 0.00;
                  }
                });
                aanaResultCalculation();
              },
            ),
            LandConverterWidget(
              hintText: 'Aana',
              textController: annaController,
              onChange: (val) {
                setState(() {
                  if(val != ''){
                    aana = double.parse(val);
                    aanaResultCalculation();
                  }else{
                    aana = 0.00;
                  }
                });
              },
            ),
            LandConverterWidget(
              hintText: 'Paisa',
              textController: paisaController,
              onChange: (val){
                setState(() {
                  if(val != ''){
                    final paisa = double.parse(val);
                    // coverting paisa to anna
                    paisaToAana = paisa / 4;
                  }else{
                    paisaToAana = 0.00;
                  }
                });
                aanaResultCalculation();
              },
            ),
            LandConverterWidget(
              hintText: 'Dam',
              textController: daamController,
              onChange: (val){
                setState(() {
                  if(val != ''){
                    final dam = double.parse(val);
                    // coverting dam to anna
                    damToAana = dam / 16;
                  }else{
                    damToAana = 0.00;
                  }
                });
                aanaResultCalculation();
              },
            ),
          ],
        ) 
        : isKattha == true ?
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LandConverterWidget(  
              hintText: 'Bigha',
              textController: bighaController,
              onChange: (val){
                setState(() {
                  if(val != ''){
                    final bigha = double.parse(val);
                    // coverting bigha to katha
                    bighaToKattha = bigha * 20;
                  }else{
                    bighaToKattha = 0.00;
                  }
                });
                katthaResultCalculation();
              },
            ),
            SizedBox(
              width: 10.w,
            ),
            LandConverterWidget(
              hintText: 'Kattha',
              textController: kathaController,
              onChange: (val){
                setState(() {
                  if(val != ''){
                    kattha = double.parse(val);
                  }else{
                    kattha = 0.00;
                  }
                });
                katthaResultCalculation();
              },
            ),
            SizedBox(
              width: 10.w,
            ),
            LandConverterWidget(
              hintText: 'Dhur',
              textController: dhurController,
              onChange: (val){
                setState(() {
                  if(val != ''){
                    final dhur = double.parse(val);
                    // coverting dhur to kattha
                    dhurTokattha = dhur / 20;
                  }else{
                    dhurTokattha = 0.00;
                  }
                });
                katthaResultCalculation();
              },
            ),
          ],
        )
        : isSqmeter == true ?
        LandConverterWidget(
          hintText: "Sq. m",
          textController: sqMeterController,
          onChange: (val){
            setState(() {
              if(val != ''){
                sqMeter = double.parse(val);
              }else{
                sqMeter = 0.00;
              }
            });
            sqmeterResultCalculation();
          },
        )
        : const SizedBox(),
      ],
    );
  }
  
  //area as per site
  areaSite() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Area as per Site", style: roboto(darkBlack, 16.0, 0.5,FontWeight.w400),), 
        SizedBox(height: 25.h,),
        isAnna == true ?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LandConverterWidget(
              hintText: 'Ropani',
              textController: ropaniSiteController,
              onChange: (val) {
                setState(() {
                  if(val != ''){
                    final ropani = double.parse(val);
                    // coverting ropani to anna
                    ropaniToAanaSite = ropani * 16;
                  }else{
                    ropaniToAanaSite = 0.00;
                  }
                });
                aanaResultCalculation();
              },
            ),
            LandConverterWidget(
              hintText: 'Aana',
              textController: annaSiteController,
              onChange: (val) {
                setState(() {
                  if(val != ''){
                    aanaSite = double.parse(val);
                  }else{
                    aanaSite = 0.00;
                  }
                });
                aanaResultCalculation();
              },
            ),
            LandConverterWidget(
              hintText: 'Paisa',
              textController: paisaSiteController,
              onChange: (val){
                setState(() {
                  if(val != ''){
                    final paisa = double.parse(val);
                    // coverting paisa to anna
                    paisaToAanaSite = paisa / 4;
                  }else{
                    paisaToAanaSite = 0.00;
                  }
                });
                aanaResultCalculation();
              },
            ),
            LandConverterWidget(
              hintText: 'Dam',
              textController: daamSiteController,
              onChange: (val){
                setState(() {
                  if(val != ''){
                    final dam = double.parse(val);
                    // coverting dam to anna
                    damToAanaSite = dam / 16;
                  }else{
                    damToAanaSite = 0.00;
                  }
                });
                aanaResultCalculation();
              },
            ),
          ],
        ) 
        : isKattha == true ?
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LandConverterWidget(  
              hintText: 'Bigha',
              textController: bighaSiteController,
              onChange: (val){
                setState(() {
                  if(val != ''){
                    final bigha = double.parse(val);
                    // coverting bigha to katha
                    bighaToKatthaSite = bigha * 20;
                  }else{
                    bighaToKatthaSite = 0.00;
                  }
                });
                katthaResultCalculation();
              },
            ),
            SizedBox(
              width: 10.w,
            ),
            LandConverterWidget(
              hintText: 'Kattha',
              textController: kathaSiteController,
              onChange: (val){
                setState(() {
                  if(val != ''){
                    katthaSite = double.parse(val);
                  }else{
                    katthaSite = 0.00;
                  }
                });
                katthaResultCalculation();
              },
            ),
            SizedBox(
              width: 10.w,
            ),
            LandConverterWidget(
              hintText: 'Dhur',
              textController: dhurSiteController,
              onChange: (val){
                setState(() {
                  if(val != ''){
                    final dhur = double.parse(val);
                    // coverting dhur to kattha
                    dhurTokatthaSite = dhur / 20;
                  }else{
                    dhurTokatthaSite = 0.00;
                  }
                });
                katthaResultCalculation();
              },
            ),
          ],
        )
        :isSqmeter == true ?
        LandConverterWidget(
          hintText: "Sq. m",
          textController: sqMeterSiteController,
          onChange: (val){
            setState(() {
              if(val != ''){
                sqMeterSite = double.parse(val);
              }else{
                sqMeterSite = 0.00;
              }
            });
            sqmeterResultCalculation();
          },
        )
        : const SizedBox(),
      ],
    );
  }

  //considerable area for valuation
  valuation(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Considerable area for Valuation", style: roboto(darkBlack, 16.0, 0.5,FontWeight.w400),),
        SizedBox(height: 25.h,),
        isAnna ?
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 58.w,
              height: 60.h,
              child: Column(
                children: [
                  Text("Ropani",style: roboto(grey.withOpacity(0.8), 15, 0.0),),
                  SizedBox(height: 6.h,),
                  Flexible(
                    child: Text("$ropaniValuation",
                      style: roboto(grey.withOpacity(0.8), 16, 0.0),
                    )
                  )
                ],
              ),
            ),
            Container(
              width: 30.w,
              padding: EdgeInsets.only(top: 2.5.h),
              child: Divider(
                color: grey.withOpacity(0.4),
                thickness: 1.4.sp,
              ),
            ),
            SizedBox(
              width: 56.w,
              height: 60.h,
              child: Column(
                children: [
                  Text("Aana",style: roboto(grey.withOpacity(0.8), 15, 0.0),),
                  SizedBox(height: 6.h,),
                  Flexible(
                    child: Text(annaValation.toString() ,
                      style: roboto(grey.withOpacity(0.8), 16, 0.0),
                    )
                  )
                ],
              ),
            ),
            Container(
              width: 30.w,
              padding: EdgeInsets.only(top: 2.5.h),
              child: Divider(
                color: grey.withOpacity(0.4),
                thickness: 1.4.sp,
              ),
            ),
            SizedBox(
              width: 56.w,
              height: 60.h,
              child: Column(
                children: [
                  Text("Paisa",style: roboto(grey.withOpacity(0.8), 15, 0.0),),
                  SizedBox(height: 6.h,),
                  Flexible(
                    child: Text(paisaValation.toString() ,
                      style: roboto(grey.withOpacity(0.8), 16, 0.0),
                    )
                  )
                ],
              ),
            ),
            Container(
              width: 30.w,
              padding: EdgeInsets.only(top: 2.5.h),
              child: Divider(
                color: grey.withOpacity(0.4),
                thickness: 1.4.sp,
              ),
            ),
            SizedBox(
              width: 56.w,
              height: 60.h,
              child: Column(
                children: [
                  Text("Dam",style: roboto(grey.withOpacity(0.8), 15, 0.0),),
                  SizedBox(height: 6.h,),
                  Flexible(
                    child: Text(daamValation.toString() ,
                      style: roboto(grey.withOpacity(0.8), 16, 0.0),
                    )
                  )
                ],
              ),
            ),
          ],
        ) 
        : isKattha ?
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 68.w,
              height: 60.h,
              child: Column(
                children: [
                  Text("Bigha",style: roboto(grey.withOpacity(0.8), 15, 0.0),),
                  SizedBox(height: 6.h,),
                  Flexible(
                    child: Text("$bighaValation",
                      style: roboto(grey.withOpacity(0.8), 16, 0.0),
                    )
                  )
                ],
              ),
            ),
            Container(
              width: 56.w,
              padding: EdgeInsets.only(top: 2.5.h),
              child: Divider(
                color: grey.withOpacity(0.4),
                thickness: 1.4.sp,
              ),
            ),
            SizedBox(
              width: 68.w,
              height: 60.h,
              child: Column(
                children: [
                  Text("Kattha",style: roboto(grey.withOpacity(0.8), 15, 0.0),),
                  SizedBox(height: 6.h,),
                  Flexible(
                    child: Text("$kathaValation",
                      style: roboto(grey.withOpacity(0.8), 16, 0.0),
                    )
                  )
                ],
              ),
            ),
            Container(
              width: 56.w,
              padding: EdgeInsets.only(top: 2.5.h),
              child: Divider(
                color: grey.withOpacity(0.4),
                thickness: 1.4.sp,
              ),
            ),
            SizedBox(
              width: 68.w,
              height: 60.h,
              child: Column(
                children: [
                  Text("Dhur",style: roboto(grey.withOpacity(0.8), 15, 0.0),),
                  SizedBox(height: 6.h,),
                  Flexible(
                    child: Text("$dhurValation",
                      style: roboto(grey.withOpacity(0.8), 16, 0.0),
                    )
                  )
                ],
              ),
            ),
          ],
        ) 
        : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 96.w,
              padding: EdgeInsets.only(top: 2.5.h),
              child: Divider(
                color: grey.withOpacity(0.4),
                thickness: 1.4.sp,
              ),
            ),
            SizedBox(
              width: 120.w,
              height: 60.h,
              child: Column(
                children: [
                  Text("Sqaure Meter",style: roboto(grey.withOpacity(0.8), 15, 0.0),),
                  SizedBox(height: 6.h,),
                  Flexible(
                    child: Text("$sqMeterValation",
                      style: roboto(grey.withOpacity(0.8), 16, 0.0),
                    )
                  )
                ],
              ),
            ),
            Container(
              width: 96.w,
              padding: EdgeInsets.only(top: 2.5.h),
              child: Divider(
                color: grey.withOpacity(0.4),
                thickness: 1.4.sp,
              ),
            ),
          ],
        )
      ],
    );
  }
  
  //result
  result() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Result".toUpperCase(), style: roboto(darkBlack, 16.0, 0.0,FontWeight.w400),),
        SizedBox(height: 25.0.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Aana  ",style: roboto(black, 15, 0.0),),
            SizedBox(width: 20.0.w,),
            Flexible(
              child: Text(aanaResult.toStringAsFixed(4) ,
                style: roboto(black, 19.5, 0.0, FontWeight.w600,), 
              )
            )
          ],
        ),
        SizedBox(height: 8.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Kattha  ",style: roboto(black, 15, 0.0),),
            SizedBox(width: 20.0.w,),
            Flexible(
              child: Text(katthaResult.toStringAsFixed(4),
                style: roboto(black, 19.5, 0.0, FontWeight.w600,), 
              )
            )
          ],
        ),
        SizedBox(height: 8.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Square Meter ",style: roboto(black, 15, 0.0),),
            SizedBox(width: 20.0.w,),
            Flexible(
              child: Text(sqMeterResult.toStringAsFixed(4),
                style: roboto(black, 19.5, 0.0, FontWeight.w600,), 
              )
            )
          ],
        ),
      ],
    );
  }
  
  //rate
  rate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rate'.toUpperCase(), style: roboto(darkBlack, 16.0, 0.0,FontWeight.w400),),
        SizedBox(height: 15.0.h,),
        //drop down
        CustomTextField(
          ontap: (){
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  color: white,
                  height: MediaQuery.of(context).size.height*0.3,
                  child: Column(
                    children: [
                      Container(
                        color: lightGrey.withOpacity(0.2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            child: Text("Cancel",style: roboto(violet, 16.0, 0.0),),
                            ),
                            MaterialButton(
                              onPressed: (){
                                if(dropDownController.text == ''){
                                  setState(() {
                                  dropDownController.text = values[0];
                                  });
                                }
                                Navigator.pop(context);
                              },
                              child: Text("Done",style: roboto(violet, 16.0, 0.0),),
                            )
                          ]
                        ),
                      ),
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: FixedExtentScrollController(initialItem: indexRate()),
                          onSelectedItemChanged: (value) => 
                            setState(() {
                              dropDownController.text = values[value];
                            }),
                          itemExtent: 40.sp,
                          children: values.map((value) => Center(child: Text(value,style: roboto(black, 16.0, 0.0),))).toList(),
                        ),
                      )
                    ],
                  ),
                );
              }
            );
          },
          textController: dropDownController,
          readOnly: true,
          keyboardType: TextInputType.number,
          textFieldWidth: 340.0.w,
          textfieldHeight: 45.0.h,
          hintText: "Select Unit",
          suffixIcon: const Icon(Icons.expand_more_rounded, color: lightGrey,),
        ),
        SizedBox(height: 25.0.h,),
        //govtrate
        Row(
          children: [
            Text("Government Rate",style: roboto(black, 16, 0.0),),
            const Spacer(),
            InkWell(
              onTap: () async{
                var networkStatus = await checkInitialConnectivity();
                if(networkStatus == true){
                  launchUrl(
                    Uri.parse("https://www.dolma.gov.np/office/dept/content/fiscal-year-2079-080-1659243606?fbclid=IwAR3Ar-ZtAhUIPGUlNZVrIGyJYwRi1vrJdK1-7mWcKvRN9H1HY4EHZG3vXLM"),
                    mode: LaunchMode.externalApplication
                  );
                } else{
                  // ignore: use_build_context_synchronously
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
              child: SizedBox(
                child: Row(
                  children: [
                    const Icon(Icons.link, size: 21, color: violet,),
                    SizedBox(width: 4.w,),
                    Text("View Rate",style: roboto(violet, 14, 0.0),),
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 15.h,),
        LandConverterWidget(
          width: 340.w,
          hintText: dropDownController.text == "Aana" 
                  ? "Rate for Aana"
                  : dropDownController.text == "Kattha"
                  ? "Rate for Kattha"
                  : dropDownController.text == "Square Meter"
                  ? "Rate for Sq. meter"
                  : "Rate",
          textController: govtRateController,
        ),
        SizedBox(height: 25.0.h,),
        //commercialrate
        Text("Commercial Rate",style: roboto(black, 16, 0.0),),
        SizedBox(height: 15.h,),
        LandConverterWidget(
          width: 340.w,
          hintText: dropDownController.text == "Aana" 
                  ? "Rate for Aana"
                  : dropDownController.text == "Kattha"
                  ? "Rate for Kattha"
                  : dropDownController.text == "Square Meter"
                  ? "Rate for Sq. meter"
                  : "Rate",
          textController: commercialRateController,
        ),
        valuationRate == true ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.0.h,),
            Divider(
              color: grey.withOpacity(0.15),
              thickness: 1.sp,
            ),
            SizedBox(height: 20.0.h,),
            //rate result
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Weighted Avg Value",style: roboto(black, 16, 0.0),),
                    SizedBox( height:  8.h,),
                    Text("रु ${weighteAvgRate.toStringAsFixed(2)}",style: roboto(black, 20, 0.0, FontWeight.w600, ), ),
                  ],
                ),
                const Spacer(),
                CustomTextField(
                  ontap: (){
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          color: white,
                          height: MediaQuery.of(context).size.height*0.3,
                          child: Column(
                            children: [
                              Container(
                                color: lightGrey.withOpacity(0.2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    MaterialButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                    child: Text("Cancel",style: roboto(violet, 16.0, 0.0),),
                                    ),
                                    MaterialButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: Text("Done",style: roboto(violet, 16.0, 0.0),),
                                    )
                                  ]
                                ),
                              ),
                              Expanded(
                                child: CupertinoPicker(
                                  scrollController: FixedExtentScrollController(initialItem: indexWeightedRatio()),
                                  onSelectedItemChanged: (value) {
                                    setState(() {
                                      weightedRatioController.text = weightedRatio[value];
                                    });
                                    rateCalculation();
                                  },
                                  itemExtent: 40.sp,
                                  children: weightedRatio.map((value) => Center(child: Text(value,style: roboto(black, 16.0, 0.0),))).toList(),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    );
                  },
                  textController: weightedRatioController,
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  textFieldWidth: 124.0.w,
                  textfieldHeight: 48.0.h,
                  labelText: "Ratio",
                  ratio: true,
                  suffixIcon: const Icon(Icons.expand_more_rounded, color: lightGrey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Distress Value of Land",style: roboto(black, 16, 0.0),),
                    SizedBox(height: 8.h,),
                    Text("रु ${distressValue.toStringAsFixed(2)}",style: roboto(black, 20, 0.0, FontWeight.w600, ), ),
                  ],
                ),
                const Spacer(),
                CustomTextField(
                  ontap: (){
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          color: white,
                          height: MediaQuery.of(context).size.height*0.3,
                          child: Column(
                            children: [
                              Container(
                                color: lightGrey.withOpacity(0.2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    MaterialButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                    child: Text("Cancel",style: roboto(violet, 16.0, 0.0),),
                                    ),
                                    MaterialButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: Text("Done",style: roboto(violet, 16.0, 0.0),),
                                    )
                                  ]
                                ),
                              ),
                              Expanded(
                                child: CupertinoPicker(
                                  scrollController: FixedExtentScrollController(initialItem: indexDistressRatio()),
                                  onSelectedItemChanged: (value) {
                                    setState(() {
                                      distressRatioController.text = distressRatio[value];
                                    });
                                    rateCalculation();
                                  },
                                  itemExtent: 40.sp,
                                  children: distressRatio.map((value) => Center(child: Text(value,style: roboto(black, 16.0, 0.0),))).toList(),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    );
                  },
                  textController: distressRatioController,
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  textFieldWidth: 124.0.w,
                  textfieldHeight: 48.0.h,
                  labelText: "Ratio",
                  ratio: true,
                  suffixIcon: const Icon(Icons.expand_more_rounded, color: lightGrey,
                  ),
                ),
              ],
            ),
          ],
        ) : const SizedBox()
      ],
    );
  }

  //calculation when isAana
  aanaResultCalculation(){
    setState(() {
      lalpurjaAanaVlaue = ropaniToAana + aana + paisaToAana +  damToAana;
      siteAanaValue = ropaniToAanaSite + aanaSite + paisaToAanaSite +  damToAanaSite;
      //aana to katha
      lalpurjaKathaVlaue = lalpurjaAanaVlaue / 10.65;
      siteKathaValue = siteAanaValue / 10.65;
      //aana to sq meter
      lalpurjaSqmVlaue = lalpurjaAanaVlaue * 31.8;
      siteSqmValue = siteAanaValue * 31.8;

      //for valuation when anna
      if(lalpurjaAanaVlaue < siteAanaValue || lalpurjaAanaVlaue == siteAanaValue){
        ropaniValuation = ropaniController.text == "" ? 0 : double.parse(ropaniController.text);
        annaValation = annaController.text == "" ? 0 : double.parse(annaController.text);
        paisaValation = paisaController.text == "" ? 0 : double.parse(paisaController.text);
        daamValation = daamController.text == "" ? 0 : double.parse(daamController.text);
      }
      else{
        ropaniValuation = ropaniSiteController.text == "" ?  0 : double.parse(ropaniSiteController.text);
        annaValation = annaSiteController.text == "" ?  0 : double.parse(annaSiteController.text);
        paisaValation = paisaSiteController.text == "" ?  0 : double.parse(paisaSiteController.text);
        daamValation = daamSiteController.text == "" ?  0 : double.parse(daamSiteController.text);
      }
      //aana result
      aanaResult = lalpurjaAanaVlaue < siteAanaValue || lalpurjaAanaVlaue == siteAanaValue 
        ? lalpurjaAanaVlaue
        : siteAanaValue;

      //katha result
      katthaResult = lalpurjaKathaVlaue < siteKathaValue || lalpurjaKathaVlaue == siteKathaValue 
        ? lalpurjaKathaVlaue
        : siteKathaValue;

      //sqMeter rsult
      sqMeterResult = lalpurjaSqmVlaue < siteSqmValue || lalpurjaSqmVlaue == siteSqmValue 
        ? lalpurjaSqmVlaue
        : siteSqmValue; 
    });
  }

  //calculation when isKattha
  katthaResultCalculation(){
    setState(() {
      lalpurjaKathaVlaue = bighaToKattha + kattha + dhurTokattha;
      siteKathaValue = bighaToKatthaSite + katthaSite + dhurTokatthaSite;
      //katha to aana
      lalpurjaAanaVlaue = lalpurjaKathaVlaue * 10.65;
      siteAanaValue = siteKathaValue * 10.65;
      //katha to sq meter
      lalpurjaSqmVlaue = lalpurjaKathaVlaue * 338.63;
      siteSqmValue = siteKathaValue * 338.63;

      //for valuation when kattha
      if(lalpurjaKathaVlaue < siteKathaValue || lalpurjaKathaVlaue == siteKathaValue){
        bighaValation = bighaController.text == "" ? 0 : double.parse(bighaController.text);
        kathaValation = kathaController.text == "" ? 0 : double.parse(kathaController.text);
        dhurValation = dhurController.text == "" ? 0 : double.parse(dhurController.text);
      }
      else{
        bighaValation = bighaSiteController.text == "" ? 0 : double.parse(bighaSiteController.text);
        kathaValation = kathaSiteController.text == "" ? 0 : double.parse(kathaSiteController.text);
        dhurValation = dhurSiteController.text == "" ? 0 : double.parse(dhurSiteController.text);
      }

      //aana result
      aanaResult = lalpurjaAanaVlaue < siteAanaValue || lalpurjaAanaVlaue == siteAanaValue 
        ? lalpurjaAanaVlaue
        : siteAanaValue;

      //katha result
      katthaResult = lalpurjaKathaVlaue < siteKathaValue || lalpurjaKathaVlaue == siteKathaValue 
        ? lalpurjaKathaVlaue
        : siteKathaValue;

      //sqMeter rsult
      sqMeterResult = lalpurjaSqmVlaue < siteSqmValue || lalpurjaSqmVlaue == siteSqmValue 
        ? lalpurjaSqmVlaue
        : siteSqmValue; 
    });
    
  }

  //calculation when isSquareMeter
  sqmeterResultCalculation(){
    setState(() {
      lalpurjaSqmVlaue = sqMeter;
      siteSqmValue = sqMeterSite;
      //sqm to katha
      lalpurjaKathaVlaue = lalpurjaSqmVlaue / 338.63;
      siteKathaValue = siteSqmValue / 338.63;
      //sqm to sq aana
      lalpurjaAanaVlaue = lalpurjaSqmVlaue / 31.8;
      siteAanaValue = siteSqmValue / 31.8;

      //for valuation when sq meter
      if(lalpurjaSqmVlaue < siteSqmValue || lalpurjaSqmVlaue == siteSqmValue){
        sqMeterValation = sqMeterController.text == "" ? 0 : double.parse(sqMeterController.text);
      }
      else{
        sqMeterValation = sqMeterSiteController.text == "" ? 0 : double.parse(sqMeterSiteController.text);
      }
      //aana result
      aanaResult = lalpurjaAanaVlaue < siteAanaValue || lalpurjaAanaVlaue == siteAanaValue 
        ? lalpurjaAanaVlaue
        : siteAanaValue;

      //katha result
      katthaResult = lalpurjaKathaVlaue < siteKathaValue || lalpurjaKathaVlaue == siteKathaValue 
        ? lalpurjaKathaVlaue
        : siteKathaValue;

      //sqMeter rsult
      sqMeterResult = lalpurjaSqmVlaue < siteSqmValue || lalpurjaSqmVlaue == siteSqmValue 
        ? lalpurjaSqmVlaue
        : siteSqmValue; 
    });
  }
  
  //calculation for rate
  rateCalculation() {
    setState(() {
      if(govtRateController.text == "" || commercialRateController.text == ""){
        weighteAvgRate = 0.0;
        distressValue =0.0;
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
            content: Text("Enter Government & Commercial Rate", style: roboto(white, 14, 0.0),),
          )
        );
      }
      else if(aanaResult == 0.00 || katthaResult == 0.00 || sqMeterResult == 0.00){
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
            content: Text("Considerable area must be calculated", style: roboto(white, 14, 0.0),),
          )
        );
      }
      else{
        if(dropDownController.text == "Aana"){
          weighteAvgRate = ((weightedRatioController.text == "50% - 50%" ? 0.5 : weightedRatioController.text == "60% - 40%" ? 0.4 
          : weightedRatioController.text == "80% - 20%" ? 0.2 : weightedRatioController.text == "90% - 10%" ? 0.1 :
            0.3) * double.parse(govtRateController.text == "" ? "0.00" : govtRateController.text)* aanaResult) +
          ((weightedRatioController.text == "50% - 50%" ? 0.5 : weightedRatioController.text == "60% - 40%" ? 0.6 :
          weightedRatioController.text == "80% - 20%" ? 0.8 : weightedRatioController.text == "90% - 10%" ? 0.9 :
          0.7) * double.parse(commercialRateController.text == "" ? "0.00" : commercialRateController.text) * aanaResult);
        }
        else if(dropDownController.text == "Kattha"){
          weighteAvgRate = ((weightedRatioController.text == "50% - 50%" ? 0.5 : weightedRatioController.text == "60% - 40%" ? 0.4 :
          weightedRatioController.text == "80% - 20%" ? 0.2 : weightedRatioController.text == "90% - 10%" ? 0.1 :
          0.3) * double.parse(govtRateController.text == "" ? "0.00" : govtRateController.text)* katthaResult) +
          ((weightedRatioController.text == "50% - 50%" ? 0.5 : weightedRatioController.text == "60% - 40%" ? 0.6 :
          weightedRatioController.text == "80% - 20%" ? 0.8 : weightedRatioController.text == "90% - 10%" ? 0.9 :
          0.7 * double.parse(commercialRateController.text == "" ? "0.00" : commercialRateController.text) * katthaResult));
        }
        else{
          weighteAvgRate = ((weightedRatioController.text == "50% - 50%" ? 0.5 : weightedRatioController.text == "60% - 40%" ? 0.4 :
          weightedRatioController.text == "80% - 20%" ? 0.2 : weightedRatioController.text == "90% - 10%" ? 0.1 :
          0.3) * double.parse(govtRateController.text == "" ? "0.00" : govtRateController.text)* sqMeterResult) +
          ((weightedRatioController.text == "50% - 50%" ? 0.5 : weightedRatioController.text == "60% - 40%" ? 0.6 :
          weightedRatioController.text == "80% - 20%" ? 0.8 : weightedRatioController.text == "90% - 10%" ? 0.9 :
          0.7 * double.parse(commercialRateController.text == "" ? "0.00" : commercialRateController.text) * sqMeterResult));
        }

        //distress rate
        distressValue = (distressRatioController.text == "10%" ? 0.1 :
                        distressRatioController.text == "20%" ? 0.2 :
                        distressRatioController.text == "30%" ? 0.3 :
                        distressRatioController.text == "40%" ? 0.4 :
                        distressRatioController.text == "50%" ? 0.5 :
                        distressRatioController.text == "60%" ? 0.6 :
                        distressRatioController.text == "70%" ? 0.7 :
                        distressRatioController.text == "90%" ? 0.9 : 0.8) * weighteAvgRate;

        //view rate result
        valuationRate = true;

        scrollCon.animateTo(
          765,  
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }
}