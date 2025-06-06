import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Resource/Strings.dart';
import '../../Widget/SubmitButtonWidget.dart';


class NoNetwork extends StatelessWidget {
  const NoNetwork({super.key});

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: SvgPicture.asset(
                      'lib/Assets/Images/nonetwork.svg',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    Strings.noInternetConnection,
                    style: GoogleFonts.inter(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    Strings.pleaseCheckYourInternetConnectionAndTryAgain,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:  Container(
        margin: EdgeInsets.only(left: 10,right: 10,bottom: 30),
        child: SubmitButtonWidget(text: Strings.tryAgain,onTap: (){},),
      ),
    );
  }
}
