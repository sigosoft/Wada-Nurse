
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';

class CheckboxWdget extends StatefulWidget {
   CheckboxWdget({super.key, required this.content, required this.size, required this.color,required this.isChecked});
  final  String content;
  final double size;
  final Color color;
  bool isChecked;
  @override
  State<CheckboxWdget> createState() => _CheckboxWdgetState();
}

class _CheckboxWdgetState extends State<CheckboxWdget> {

  @override
  Widget build(BuildContext context) {
    return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Checkbox(
        value: widget.isChecked,
        onChanged: (value) {
          setState(() {
            widget.isChecked = value!;
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        activeColor: widget.color,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      Expanded(
        child: Text(
          widget.content,
          style: GoogleFonts.inter(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: widget.size,
            color: greyishBlack,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
    ],
    );
  }
}