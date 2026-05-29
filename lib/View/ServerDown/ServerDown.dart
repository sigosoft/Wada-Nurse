import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Resource/Strings.dart';
import '../../Widget/SubmitButtonWidget.dart';

class ServerDown extends StatelessWidget {
  const ServerDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 50),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "lib/Assets/Images/Server DOwn.png",
                    height: 200,
                    width: 200,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  Strings.serverDown,
                  style: GoogleFonts.rubik(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            Positioned(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: SubmitButtonWidget(
                    text: Strings.gotIt,
                    onTap: () {
                      SystemNavigator.pop();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
