import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Resource/Strings.dart';


class Maintenance extends StatelessWidget {
  final String? serverDownReason;
  const Maintenance({super.key, this.serverDownReason});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: SvgPicture.asset(
                'lib/Assets/Images/maintenance.svg',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              Strings.wellBeBackSoon,
              style: GoogleFonts.inter(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              (serverDownReason != null && serverDownReason!.isNotEmpty && serverDownReason != "null")
                  ? serverDownReason!.replaceAll(RegExp(r'<[^>]*>'), '').trim()
                  : Strings.sorryWereDownForMaintenanceWellBeBackUpShortly,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
