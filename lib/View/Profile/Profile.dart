import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/ProfileController.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/View/ChangePassword/ChangePassword.dart';
import 'package:waaada_nurseapp/View/Documents/Documents.dart';
import 'package:waaada_nurseapp/View/Notifications/NotificationsListing.dart';
import 'package:waaada_nurseapp/View/Profile/EditProfile.dart';
import 'package:waaada_nurseapp/View/Settings/NeedAnUpdate.dart';
import 'package:waaada_nurseapp/Widget/DoctorDetailsWidget.dart';
import 'package:waaada_nurseapp/Widget/LogoutWidget.dart';
import 'package:waaada_nurseapp/Widget/ProfileAppBar.dart';
import 'package:waaada_nurseapp/Widget/ProfileRowWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithoutPadding.dart';

import '../../Resource/Colors.dart';




class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ProfileAppBar(
        onTap: () {

        },
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: GetBuilder(
            init: ProfileController(),
            builder:
                (controller) => Column(
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DoctorDetailsWidget(
                    premiumMembership: controller.premiumMembership,
                  onTapEdit: (){
                      Get.to(EditProfile());
                  },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: boxGradient,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        ProfileRowWidget(
                          svgIcon: "lib/Assets/Images/documentIcon.svg",
                          text: Strings.documents,
                          onTap: () {
                            Get.to(Documents());
                          },
                        ),
                        const Divider(color: borderLine, thickness: 1.0),
                        ProfileRowWidget(
                          svgIcon: "lib/Assets/Images/notificationIcon.svg",
                          text: Strings.notifications,
                          onTap: () {
                            Get.to(NotificationsListing());
                          },
                        ),
                        const Divider(color: borderLine, thickness: 1.0),
                        ProfileRowWidget(
                          svgIcon:
                          "lib/Assets/Images/changePasswordIcon.svg",
                          text: Strings.changePassword,
                          onTap: () {
                          Get.to(ChangePassword());
                          },
                        ),
                        const Divider(color: borderLine, thickness: 1.0),
                        ProfileRowWidget(
                          svgIcon: "lib/Assets/Images/helpCentreIcon.svg",
                          text: Strings.helpCentre,
                          onTap: () {
                           Get.to("");
                          },
                        ),
                        const Divider(color: borderLine, thickness: 1.0),
                        ProfileRowWidget(
                          svgIcon: "lib/Assets/Images/aboutUsIcon.svg",
                          text: Strings.aboutUs,
                          onTap: () {
                          Get.to("");
                          },
                        ),
                        const Divider(color: borderLine, thickness: 1.0),
                        ProfileRowWidget(
                          svgIcon: "lib/Assets/Images/faqIcon.svg",
                          text: Strings.faqs,
                          onTap: () {
                           Get.to("");
                          },
                        ),
                        const Divider(color: borderLine, thickness: 1.0),
                        ProfileRowWidget(
                          svgIcon: "lib/Assets/Images/termaAndConditionsIcon.svg",
                          text: Strings.termsAndConditions,
                          onTap: () {
                            Get.to("");
                          },
                        ),
                        const Divider(color: borderLine, thickness: 1.0),
                        ProfileRowWidget(
                          svgIcon: "lib/Assets/Images/privacyPolicyIcon.svg",
                          text: Strings.privacyPolicy,
                          onTap: () {
                            Get.to("");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                LogoutWidget(
                  onTap: () {
                    controller.showLogoutShiftBottomSheet(context);
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextStyleInterWithoutPadding(
                        text: "v.1.2.3.4",
                        color: versionCodeGray,
                        fontWeight: FontWeight.w500,
                        size: 14.00,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.showDeleteAccountBottomSheet(context);
                        },
                        child: TextStyleInterWithoutPadding(
                          text: Strings.deleteAccount,
                          color: versionCodeGray,
                          fontWeight: FontWeight.w500,
                          size: 14.00,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(NeedAnUpdate());
                        },
                        child: TextStyleInterWithoutPadding(
                          text: Strings.checkForUpdate,
                          color: versionCodeGray,
                          fontWeight: FontWeight.w500,
                          size: 14.00,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
