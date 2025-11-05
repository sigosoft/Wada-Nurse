import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import '../Resource/Strings.dart';

class DateOfBirthField extends StatefulWidget {
  const DateOfBirthField({
    super.key,
    this.validatorText,
    this.selectedDateOfBirth,
    this.onDateSelected,
  });

  final String? validatorText;
  final DateTime? selectedDateOfBirth;
  final Function(DateTime?)? onDateSelected;

  @override
  State<DateOfBirthField> createState() => _DateOfBirthFieldState();
}

class _DateOfBirthFieldState extends State<DateOfBirthField> {
  final TextEditingController _dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateControllerFromSelectedDate();
  }

  @override
  void didUpdateWidget(DateOfBirthField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDateOfBirth != widget.selectedDateOfBirth) {
      _updateControllerFromSelectedDate();
    }
  }

  void _updateControllerFromSelectedDate() {
    if (widget.selectedDateOfBirth != null) {
      final dateString = "${widget.selectedDateOfBirth!.toLocal()}".split(' ')[0];
      _dobController.text = dateString;
    } else {
      _dobController.clear();
    }
  }

  Future<void> _openDatePicker(
    BuildContext context,
    FormFieldState<String> field,
  ) async {
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
      final dateString = "${selectedDate.toLocal()}".split(' ')[0];
      
      // Temporarily update the text field
      setState(() {
        _dobController.text = dateString;
      });
      field.didChange(dateString);
      
      // Call the callback - if validation fails, it won't update selectedDateOfBirth
      widget.onDateSelected?.call(selectedDate);
      
      // After a short delay, sync with the actual selectedDateOfBirth value
      // This ensures if validation failed, the text field reverts to the previous value
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted && widget.selectedDateOfBirth != selectedDate) {
          _updateControllerFromSelectedDate();
          field.didChange(_dobController.text);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: FormField<String>(
        initialValue: _dobController.text,
        autovalidateMode: AutovalidateMode.disabled,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.validatorText;
          }
          return null;
        },
        builder: (FormFieldState<String> field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => _openDatePicker(context, field),
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
                        child: TextField(
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
              if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 4),
                  child: Text(
                    field.errorText ?? '',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }
}
