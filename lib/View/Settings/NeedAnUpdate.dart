import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Resource/Strings.dart';
import '../../Widget/SubmitButtonWidget.dart';


class NeedAnUpdate extends StatelessWidget {
  const NeedAnUpdate({super.key});

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 200,
                  child: SvgPicture.asset(
                    'lib/Assets/Images/waadaLogo.svg',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  Strings.needsAnUpdate,
                  style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                 Text(
                   Strings.aNewUpdateIsAvailableForThisAppPleaseDownload,
                   textAlign: TextAlign.center,
                   style: GoogleFonts.baloo2(
                       fontSize: 15,
                       fontWeight: FontWeight.w400,
                       color: Colors.black),
                ),

              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: SubmitButtonWidget(
                text: Strings.update, onTap: () {  },
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Platform.isIOS
              ? Image.asset('lib/Assets/Images/appstore.png',width: 150,
          )
              : Image.asset("lib/Assets/Images/google_play.png",width: 150,)
      ),
    );
  }
}
