import 'dart:async';

import 'package:covid_tracker/View/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _contoller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
void dispose(){
  super.dispose();
  _contoller.dispose();
}
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: ((context) => WorldStats())));
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                child: Container(
                  width: 40.w,
                  height: 20.h,
                  child: Image.asset('images/virus.png'),
                ),
                animation: _contoller,
                builder: (context, Widget? child) {
                  return Transform.rotate(
                    angle: _contoller.value * 2.0 * math.pi,
                    child: child,
                  );
                }),
            SizedBox(
              height: 1.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Text("Covid-19 Tracking App \n By Rohaan",textAlign: TextAlign.center, style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500
                )
              ),),
            )
          ],
        ),
      ),
    );
  }
}
