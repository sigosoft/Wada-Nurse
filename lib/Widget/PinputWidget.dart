import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';


class PinPutWidget extends StatelessWidget {
  const PinPutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10),
      child: Center(
        child: Pinput(
          length: 6,
          defaultPinTheme: PinTheme(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: greyBg,
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}