import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/SettingsController.dart';
import '../../Resource/Strings.dart';
import '../../Resource/colors.dart';
import '../../Widget/CustomAppBar.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          label: Strings.aboutUs,
          showCloseIcon: false,
        ),
        body: GetBuilder<SettingsController>(
          init: SettingsController(),
          initState: (_) {},
          builder: (controller) {
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 20),
                child: Text("Cupidatat irure theas Laborum magna nulla duis ullamco cillum dolor. Sed ut perspicviatis unde omnis iste natus error sit voluptatem accusantium doloremque Cupidatat irure theas Laborum magna nulla duis ullamco cillum dolor. Sed ut perspicviatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illoamet inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, quiamet dolorem ipsum quia dolor sit amet, cons tbsa, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrumamet exercitationem ullam corporis suscipitamet laboriosam, nisi ut aliquid ex ea commodi consequatur",
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: greyishBlack)),
              ),
            );
          },
        ));
  }
}
