
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/View/Login/Login.dart';
import 'package:waaada_nurseapp/Widget/ButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [blueGradient1, blueGradient2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  "lib/Assets/Images/waadaLogo.svg",
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(height: 30),
              SvgPicture.asset(
                "lib/Assets/Images/nursing_home.svg",
                fit: BoxFit.scaleDown,
              ),
              SizedBox(height: 50),
             TextStyleInterWithPadding(
                text: "Lorem ipsum",
                color: Colors.white,
                fontWeight: FontWeight.w600,
                size: 25.00,
              ),
              SizedBox(height: 20),
             TextStyleInterWithPadding(
                text:
                "Quis autem vel eum iure reprehenderit qui in eareda voluptate velit.",
                color: Colors.white,
                fontWeight: FontWeight.w400,
                size: 15.00,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ButtonWidget(
                  onTap:(){
                    Get.off(LoginScreen());
                  },
                  text: "Get Started"),
            ],
          ),
        ),
      ),
    );
  }
}
