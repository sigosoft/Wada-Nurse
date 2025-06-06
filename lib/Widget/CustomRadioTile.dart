import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';

class CustomRadioTile extends StatelessWidget {
  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const CustomRadioTile({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: greyBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: (val) => onChanged(val!),
              activeColor: Colors.black,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            Text(
              label,
              style:GoogleFonts.inter(
                textStyle: Theme.of(context).textTheme.displayLarge,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                fontStyle: FontStyle.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
