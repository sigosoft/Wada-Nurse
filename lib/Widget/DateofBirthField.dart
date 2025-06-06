import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import '../Resource/Strings.dart';

class DateOfBirthField extends StatefulWidget {
  const DateOfBirthField({super.key});

  @override
  State<DateOfBirthField> createState() => _DateOfBirthFieldState();
}

class _DateOfBirthFieldState extends State<DateOfBirthField> {
  final TextEditingController _dobController = TextEditingController();

  Future<void> _openDatePicker(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: colorPrimary, // Top bar color
              onPrimary: Colors.white, // Text color on top bar
              onSurface: Colors.black, // Text color on surface
            ),
            dialogBackgroundColor: Colors.white, // Background color
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: colorPrimary, // Button text color
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: colorPrimary, // Header background color
              headerForegroundColor: Colors.white, // Header text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (selectedDate != null) {
      setState(() {
        _dobController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => _openDatePicker(context),
        child: AbsorbPointer(
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.transparent),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextFormField(
                  controller: _dobController,
                  readOnly: true,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    labelText: Strings.dob,
                    labelStyle: GoogleFonts.inter(
                      fontSize: 12,
                      color: blackTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                      ),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF3F3F3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}