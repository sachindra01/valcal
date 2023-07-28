
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

//Colors
const white = Color(0xffffffff);
const darkBlack = Color(0xff000000);
const grey= Color(0xff6B6B6B);
const scaffoldBg = Color(0xffffffff);
const black = Color(0xff111111);
const appBarColor = Color(0xffFFFBFE);
const appBarIconCol = Color(0xff49454F);
const violet = Color(0xff6E41E2);
const buttonbgColor = Color(0xff383c41);
const violetWeb = Color(0xff6750A4);
const lightGrey = Color.fromARGB(255, 163, 163, 163);
const red = Color(0xffFF565E);
const pink = Color(0xffF35555);
const blackColor = Colors.black;
const lightGreyColor = Color(0xffA4B8D0);
const greytextColor = Color(0xffBCA4A4);
const green = Color(0xff3ED598);
const formBgColor =Color(0xffF9F7FF);
const brown =Color(0xffD18450);
const sideNavExpansionBg =Color.fromARGB(255, 235, 237, 240);
const sideNavYellow =Color(0xffEFC11E);
const appbarWebFontColor =  Color.fromARGB(255, 153, 150, 150);

//Fonts
roboto(color, double fontsize, double letterSpacing, [fontWeight, lineheight]) => GoogleFonts.roboto(fontSize: fontsize.sp, fontWeight: fontWeight ?? FontWeight.normal, color: color, letterSpacing: letterSpacing, height: lineheight);
montserrat(color, double fontsize, double letterSpacing, [fontWeight]) => GoogleFonts.montserrat(fontSize: fontsize.sp, fontWeight: fontWeight ?? FontWeight.normal, color: color, letterSpacing: letterSpacing,);
poppins(color, double fontsize, double letterSpacing, [fontWeight]) => GoogleFonts.poppins(fontSize: fontsize, fontWeight: fontWeight ?? FontWeight.normal, color: color, letterSpacing: letterSpacing,);