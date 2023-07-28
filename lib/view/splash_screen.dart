import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landconverter/view/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigatetohome();
  }

  navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff383b40),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Image.asset(
            "assets/img/mulyankan_logo.png",
            height: 150.h,
            width: 150.h,
          ),
        ),
      ),
    );
  }
}
