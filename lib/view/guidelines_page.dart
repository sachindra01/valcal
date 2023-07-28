import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landconverter/list/data_list.dart';
import 'package:landconverter/services/analytic_services.dart';
import 'package:landconverter/style/style.dart';
import 'package:landconverter/widget/bullet_tile.dart';
import 'package:landconverter/widget/custom_appbar.dart';
import 'package:landconverter/widget/guideline_table_tile.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({super.key});

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  String selectUnit = "English";
  bool isExpanded = false;

  @override
  void initState() {
    currentScreenAnalytics();
    super.initState();
  }

  //Analytics
  Future currentScreenAnalytics() async {
    AnalyticsService.analytics.setCurrentScreen(screenName: "guidelines_page", screenClassOverride: "guidelines_page");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: customAppBar(context,"Guidlines", true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   width: double.infinity,
            //   margin: EdgeInsets.only(top:10.0.h, left: 10.w, right: 10.0.w, bottom: 0.0.h),
            //   padding: EdgeInsets.symmetric(horizontal :12.0.w, vertical: 0.0.h),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10.0.r),
            //     color: formBgColor,
            //   ),
            //   child: selectLanguage(), //Select Language
            // ),
            //Body
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
                  nepaliGuideLines()
                  // selectUnit == "English" ?
                  // englishGuideLines():
                  // nepaliGuideLines(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Choose Language
  selectLanguage(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Choose Language".toUpperCase(), style: roboto(darkBlack, 14.0, 0.0),),
            const Spacer(),
            //Select Language
            Container(
              height: 35.0.h,
              width: 134.0.w,
              decoration: BoxDecoration(
                color: white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border:  Border(
                  top: BorderSide(width: 1, color: lightGrey.withOpacity(0.3)),
                  left: BorderSide(width: 1, color: lightGrey.withOpacity(0.3)),
                  right: BorderSide(width: 1, color: lightGrey.withOpacity(0.3)),
                  bottom: BorderSide(width: 1, color: lightGrey.withOpacity(0.3)),
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        selectUnit = "English";
                      });
                    },
                    child: Container(
                      width: 66.0.w,
                      decoration: BoxDecoration(
                        color: selectUnit == "English" ? violet.withOpacity(0.8) : white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0.r))
                      ),
                      child: Center(
                        child: Text("English", 
                          style: selectUnit == "English" ? roboto(white, 13.0, 0.0) : roboto(black, 13.0, 0.0),
                        )
                      )
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                    setState(() {
                        selectUnit = "Nepali";
                      });
                    },
                    child: Container(
                      width: 66.0.w,
                      decoration: BoxDecoration(
                        color: selectUnit == "Nepali" ? violet.withOpacity(0.8) : white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0.r))
                        ),
                      child: Center(
                        child: Text("Nepali",
                          style: selectUnit == "Nepali" ? roboto(white, 13.0, 0.0) : roboto(black, 13.0, 0.0),
                        )
                      )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  //Guidelines Nepali
  nepaliGuideLines(){
    return SizedBox(
      // height: MediaQuery.of(context).size.height * 0.735,//Use it when the choose locaiton container is not there
      height: MediaQuery.of(context).size.height * 0.8,//Use it when the choose locaiton container is there
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            SizedBox(
            width: double.infinity,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: guideLines.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    iconColor: Colors.grey,
                    collapsedBackgroundColor: grey.withOpacity(0.3),
                    tilePadding: const EdgeInsets.symmetric(horizontal: 10),
                    //Expansion Tile heading
                    title: Text(guideLines[index]["title"].toString(), style: roboto(black, 15, 0.2, FontWeight.w700)),
                    onExpansionChanged: (value) {
                    },
                    //Tile Content
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(guideLines[index]["content"].toString(), style: roboto(black, 13, 0.2),),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }, 
              separatorBuilder: (context, idx)=>SizedBox(height: 10.h,),),
            ),
            //For on point with a table like structure
            SizedBox(height: 10.h,),
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                iconColor: grey,
                collapsedBackgroundColor: grey.withOpacity(0.3),
                tilePadding: const EdgeInsets.symmetric(horizontal: 10),
                //Expansion Tile heading
                title: Text("अनुपात/ % भार", style: roboto(black, 15, 0.2, FontWeight.w700)),
                onExpansionChanged: (value) {
                },
                //Tile Content
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("जग्गा मुल्याँकन गर्दा लिनुपर्ने आधारहरुः", style: roboto(black, 13.5, 0.2),),
                        SizedBox(height: 12.h,),
                        //Point 1
                        RichText(
                          text: TextSpan(
                            text: 'चलनचल्ती मुल्यको ८०% र मालपोत कार्यालयको २०% :  ',
                            style:  roboto(black, 13, 0.2, FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'महानगरपालिका, उपमहानगरपालिका र नगरपालिका भित्र पर्ने प्रमुख ब्यापारिक केन्द्रमा प्रमुख ब्यापारिक सडकसंग जोडिएको जग्गाहरु ।',
                                style: roboto(black, 13, 0.2),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h,),
                        //Point 2
                        RichText(
                          text: TextSpan(
                            text: 'चलनचल्ती मुल्यको ७५% र मालपोत कार्यालयको २५% :  ',
                            style:  roboto(black, 13, 0.2, FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'महानगरपालिका, उपमहानगरपालिका र नगरपालिका भित्र पर्ने ब्यापारिक केन्द्र (मोटरेवल सडक, विजुली, टेलिफोन, बजार जस्ता सुविधाहरु भएको) जग्गाहरु ।',
                                style: roboto(black, 13, 0.2),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h,),
                        //Point 3
                        RichText(
                          text: TextSpan(
                            text: 'चलनचल्ती मुल्यको ७०% र मालपोत कार्यालयको ३०%  :  ',
                            style:  roboto(black, 13, 0.2, FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'महानगरपालिका, उपमहानगरपालिका र नगरपालिका भित्र पर्ने मोटरेवल सडक, विजुली, टेलिफोन, बजार जस्ता सुविधाहरु भएको सडकसंग जोडिएको ब्यापारिक, आवासीय केन्द जग्गाहरु ।',
                                style: roboto(black, 13, 0.2),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h,),
                        //Middle Text
                        Text("महानगरपालिकाका वडाहरुसँग जोडीएका नगरोउन्मुख स्थानहरुमा रहेको मोटरेवल सडक, विजुली, टेलिफोन, बजार जस्ता सुविधाहरु भएको सडकसंग जोडिएको ब्यापारिक, आवासीय केन्द्रको जग्गहरु । ", style: roboto(black, 13, 0.2),),
                        SizedBox(height: 12.h,),
                        //Point 1
                        RichText(
                          text: TextSpan(
                            text: 'चलनचल्ती मुल्यको ६५% र मालपोत कार्यालयको ३५% :  ',
                            style:  roboto(black, 13, 0.2, FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'गाउँपालिका भित्र पानी, बत्ती, टेलिफोन, यातायात सुविधा जस्ता पुर्वाधारहरु भएको र महानगर, उप महानगर तथा नगरपालिकासँग जोडिएको तथा बजार क्षेत्रमा हुनुपर्ने पुर्वाधार भएको व्यापारिक तथा आवासीय क्षेत्र र पानी, बत्ती, टेलिफोन, यातायात सुविधा (पिच/ग्राभेल) जस्ता पुर्वाधारहरु भएको बजार तथा आवासीय क्षेत्रमा रहेको जग्गाहरु ।',
                                style: roboto(black, 13, 0.2),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h,),
                        //Point 2
                        RichText(
                          text: TextSpan(
                            text: 'चलनचल्ती मुल्यको ६०% र मालपोत कार्यालयको ४०% :  ',
                            style:  roboto(black, 13, 0.2, FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'महानगरपालिका, उपमहानगरपालिका र नगरपालिका भित्र पर्ने मोटर चल्ने सडकबाट बढीमा २०० मिटरसम्मभित्र अवस्थित गोरेटो बाटो भएको बाक्लो आवास क्षेत्रको जग्गाहरु साथै गाउँपालिका भित्र सामान्य वस्ती र गाडी चल्ने बाटो भएको घडेरी जग्गाहरु । ',
                                style: roboto(black, 13, 0.2),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h,),
                        //Point 3
                        RichText(
                          text: TextSpan(
                            text: 'चलनचल्ती मुल्यको ५०% र मालपोत कार्यालयको ५०%  :  ',
                            style:  roboto(black, 13, 0.2, FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'गाउँपालिका भित्र गाउँमा अवस्थित गाडी चल्ने बाटो भएको कृषि योग्य जग्गाहरु ।',
                                style: roboto(black, 13, 0.2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // //Main Heading
            // Center(
            //   child: Text("धितो सुरक्षण मूल्याँकन निर्देशिका, २०६४ (संशोधन समेत)", style: roboto(black, 22, 0.2, FontWeight.w600), textAlign: TextAlign.center,)
            // ),
            // SizedBox(height: 35.h,),
            // //5. section  (Mulyankankarta haru ko lagi nirdeshan)
            // Text("मुल्याँकनकर्ताहरुको लागि निर्देशन", style: roboto(black, 18, 0.2, FontWeight.w900),),
            // SizedBox(height: 8.h,),
            // //Points
            // SizedBox(
            //   width: double.infinity,
            //   child: ListView.separated(
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: mulyankanNirdeshanNepali.length,
            //     shrinkWrap: true,
            //     itemBuilder: (context, index){
            //       return BulletTile(text: mulyankanNirdeshanNepali[index]);
            //     }, 
            //     separatorBuilder: (context, idx)=>SizedBox(height: 10.h,),),
            // ),
            // SizedBox(height: 40.h,),
            // //5.1 Section(Bank le shurachyan bapat swikaar garna namilne dhito shurachyanharu)
            // Text("बैंकले सुरक्षण वापत स्विकार गर्न नमिल्ने धितो सुरक्षणहरु", style: roboto(black, 18, 0.2, FontWeight.w900),),
            // SizedBox(height: 8.h,),
            // //Points
            // SizedBox(
            //   width: double.infinity,
            //   child: ListView.separated(
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: bankSurachyanNepali.length,
            //     shrinkWrap: true,
            //     itemBuilder: (context, index){
            //       return BulletTile(text: bankSurachyanNepali[index]);
            //     }, 
            //     separatorBuilder: (context, idx)=>SizedBox(height: 10.h,),),
            // ),
            // SizedBox(height: 40.h,),
            // //5.2 Section
            // Text("जग्गा मुल्याँकन गर्दा लिनुपर्ने आधारहरु", style: roboto(black, 18, 0.2, FontWeight.w900),),
            // SizedBox(height: 15.h,),
            // //1.City Area
            // Text("१. शहरी क्षेत्र", style: roboto(black, 14, 0.2),),
            // SizedBox(height: 6.h,),
            // SizedBox(
            //   width: double.infinity,
            //   child: ListView.separated(
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: jaggaMulyankanAdhaarCityNepali.length,
            //     shrinkWrap: true,
            //     itemBuilder: (context, index){
            //       return GuidelineTableTile(
            //         language: selectUnit,
            //         place: jaggaMulyankanAdhaarCityNepali[index]["place"].toString(), 
            //         services: jaggaMulyankanAdhaarCityNepali[index]["services"].toString(), 
            //         toRecieveAmount: jaggaMulyankanAdhaarCityNepali[index]["valueToMaintain"].toString()
            //       );
            //     }, 
            //     separatorBuilder: (context, idx)=>SizedBox(height: 10.h,),),
            // ),
            // SizedBox(height: 40.h,),
            // //2.Village Area
            // Text("२. ग्रामीण क्षेत्र", style: roboto(black, 14, 0.2),),
            // SizedBox(height: 6.h,),
            // SizedBox(
            //   width: double.infinity,
            //   child: ListView.separated(
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: jaggaMulyankanAdhaarVillageNepali.length,
            //     shrinkWrap: true,
            //     itemBuilder: (context, index){
            //       return GuidelineTableTile(
            //         language: selectUnit,
            //         place: jaggaMulyankanAdhaarVillageNepali[index]["place"].toString(), 
            //         services: jaggaMulyankanAdhaarVillageNepali[index]["services"].toString(), 
            //         toRecieveAmount: jaggaMulyankanAdhaarVillageNepali[index]["valueToMaintain"].toString()
            //       );
            //     }, 
            //     separatorBuilder: (context, idx)=>SizedBox(height: 10.h,),),
            // ),
            // SizedBox(height: 10.h,),
            // //3.Point
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     SizedBox(
            //       width: 12.w,
            //       child: Text("३.", style: roboto(black, 13, 0.2),)
            //     ),
            //     SizedBox(
            //       width: 8.w,
            //     ),
            //     SizedBox(
            //       width: 294.w,
            //       child: Text("माथि उल्लेख भए बमोजिम बाटो भएको स्थिर सम्पत्ति धितो लिंदा स्थानिय निकायले कम्तिमा ३ वर्षदेखि सार्बजनिक बाटोको रुपमा प्रयोग भैरहेको भनि प्रमाणित गर्नु पर्नेछ।", style: roboto(black, 13, 0.2),)
            //     ),
            //   ],
            // ),
            // SizedBox(height: 6.h,),
          ],
        ),
      ),
    );
  }

  //Guidelines English
  englishGuideLines(){
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.735,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Main Heading
            Center(
              child: Text("Securities Valuation Guidelines, 2064 (Including Amendments)", style: roboto(black, 22, 0.2, FontWeight.w600), textAlign: TextAlign.center,)
            ),
            SizedBox(height: 35.h,),
            //5. section  (Mulyankankarta haru ko lagi nirdeshan)
            Text("Instructions for Assessors", style: roboto(black, 18, 0.2, FontWeight.w900),),
            SizedBox(height: 8.h,),
            //Points
            SizedBox(
              width: double.infinity,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: mulyankanNirdeshanEnglish.length,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return BulletTile(text: mulyankanNirdeshanEnglish[index]);
                }, 
                separatorBuilder: (context, idx)=>SizedBox(height: 10.h,),),
            ),
            SizedBox(height: 40.h,),
            //5.1 Section(Bank le shurachyan bapat swikaar garna namilne dhito shurachyanharu)
            Text("Mortgage security not accepted by the bank as securities", style: roboto(black, 18, 0.2, FontWeight.w900),),
            SizedBox(height: 8.h,),
            //Points
            SizedBox(
              width: double.infinity,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bankSurachyanEnglish.length,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return BulletTile(text: bankSurachyanEnglish[index]);
                }, 
                separatorBuilder: (context, idx)=>SizedBox(height: 10.h,),),
            ),
            SizedBox(height: 40.h,),
            //5.2 Section
            Text("Basis to be taken while valuing land", style: roboto(black, 18, 0.2, FontWeight.w900),),
            SizedBox(height: 15.h,),
            //1.City Area
            Text("1. Urban Area", style: roboto(black, 14, 0.2),),
            SizedBox(height: 6.h,),
            SizedBox(
              width: double.infinity,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: jaggaMulyankanAdhaarCityEnglish.length,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return GuidelineTableTile(
                    language: selectUnit,
                    place: jaggaMulyankanAdhaarCityEnglish[index]["place"].toString(), 
                    services: jaggaMulyankanAdhaarCityEnglish[index]["services"].toString(), 
                    toRecieveAmount: jaggaMulyankanAdhaarCityEnglish[index]["valueToMaintain"].toString()
                  );
                }, 
                separatorBuilder: (context, idx)=>SizedBox(height: 10.h,),),
            ),
            SizedBox(height: 40.h,),
            //2.Village Area
            Text("2. Rural Areas", style: roboto(black, 14, 0.2),),
            SizedBox(height: 6.h,),
            SizedBox(
              width: double.infinity,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: jaggaMulyankanAdhaarVillageEnglish.length,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return GuidelineTableTile(
                    language: selectUnit,
                    place: jaggaMulyankanAdhaarVillageEnglish[index]["place"].toString(), 
                    services: jaggaMulyankanAdhaarVillageEnglish[index]["services"].toString(), 
                    toRecieveAmount: jaggaMulyankanAdhaarVillageEnglish[index]["valueToMaintain"].toString()
                  );
                }, 
                separatorBuilder: (context, idx)=>SizedBox(height: 10.h,),),
            ),
            SizedBox(height: 10.h,),
            //3.Point
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 12.w,
                  child: Text("3.", style: roboto(black, 13, 0.2),)
                ),
                SizedBox(
                  width: 8.w,
                ),
                SizedBox(
                  width: 294.w,
                  child: Text("As mentioned above, when taking a mortgage on immovable property with a road, the local body must prove that it has been used as a public road for at least 3 years.", style: roboto(black, 13, 0.2),)
                ),
              ],
            ),
            SizedBox(height: 6.h,),
          ],
        ),
      ),
    );
  }
}