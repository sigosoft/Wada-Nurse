import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/SettingsController.dart';
import '../../Resource/Strings.dart';
import '../../Resource/colors.dart';
import '../../Widget/CustomAppBar.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          label: Strings.faqs,
          showCloseIcon: false,
          onTap: Get.back,
        ),
        body: GetBuilder<SettingsController>(
            init: SettingsController(),
            initState: (_) {},
            didChangeDependencies: (state) async {
              // state.controller?.getFaq(context);
            },
            builder: (controller) {
              return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    controller.faqData.length == 0
                        ? Container()
                        : Container(
                      margin: EdgeInsets.all(15),
                          child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.faqData.length,
                              itemBuilder: (_, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        color: boxBg,
                                        border: Border.all(
                                            color: boxBg, width: 1)),
                                    child: ExpansionTile(
                                      iconColor: Colors.black,
                                      collapsedIconColor: Colors.black,
                                      tilePadding: EdgeInsets.symmetric(
                                          horizontal: 15),
                                      // Remove default padding
                                      childrenPadding: EdgeInsets.zero,
                                      // Remove default padding from children
                                      shape: Border(),
                                      trailing: controller.expanded[i]
                                          ? const Icon(Icons.remove)
                                          : const Icon(Icons.add),
                                      onExpansionChanged: (value) {
                                        controller.expanded[i] =
                                            !controller.expanded[i];
                                        controller.update();
                                      },
                                      title: Text(
                                        controller.faqData[i]["title"]
                                                .toString() ??
                                            "",
                                          style: GoogleFonts.inter(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: greyishBlack)
                                      ),
                                      children: [
                                        Container(
                                          // Wrap children to avoid auto-divider
                                          decoration: BoxDecoration(
                                            color: boxBg,
                                            // Ensure no extra background color
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              bottomRight:
                                                  Radius.circular(15),
                                            ),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 15),
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                controller.faqData[i]
                                                            ["subtitle"]
                                                        .toString() ??
                                                    "",
                                                textAlign: TextAlign.left,
                                                  style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: greyishBlack)
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                    SizedBox(
                      height: 20,
                    )
                  ]);
            }));
  }
}
