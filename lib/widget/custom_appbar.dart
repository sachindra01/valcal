import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landconverter/style/style.dart';

AppBar customAppBar( context,[title, leading, action]){
  return AppBar(
    toolbarHeight: 64.0.h,
    backgroundColor: appBarColor,
    title:Text(title.toUpperCase()),
    centerTitle: leading == true? true:true,
    elevation: 0.0,
    titleTextStyle: roboto(black, 20.0, 0.0, FontWeight.w600),
    automaticallyImplyLeading: leading == true? true:false,
    iconTheme: const IconThemeData(color: black),
    actions: [
      action ?? const SizedBox()
    ],
  );
}