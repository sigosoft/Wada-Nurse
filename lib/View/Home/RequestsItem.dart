// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:waaada_nurseapp/Resource/Colors.dart';
//
// import '../../Resource/Strings.dart';
// import '../../Widget/HomeShiftCardWidget.dart';
// import '../Shift/ShiftDetails.dart';
//
// class RequestsItem extends StatelessWidget {
//   const RequestsItem({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Get.to(ShiftDetails());
//       },
//       child: Container(
//         height: 220,
//         margin: const EdgeInsets.only(bottom: 10),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: boxBg,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                         Text(
//                           "David Thomas",
//                           style: GoogleFonts.inter(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           "Age: 75 | Gender: M",
//                           style: GoogleFonts.inter(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.grey,
//                           ),
//                         ),
//                             SizedBox(height: 5),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 SvgPicture.asset(
//                                   'lib/Assets/Images/locations.svg',
//                                   width: 13,
//                                   height: 13,
//                                 ),
//                                 SizedBox(width: 5),
//                                 Text(
//                                   "Raipur, Chhattisgarh",
//                                   style: GoogleFonts.inter(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     color: colorPrimary,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                       ])),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       alignment: Alignment.centerRight,
//                       child: Text(
//                         "₹4,000",
//                         style: GoogleFonts.inter(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Expanded(
//                     child: HomeShiftCardWidget(
//                       date: "08 Feb 2025",
//                       type: Strings.checkindate,
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: HomeShiftCardWidget(
//                       date: "09:00 AM",
//                       type: Strings.checkintime,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Expanded(
//                     child: HomeShiftCardWidget(
//                       date: "08 Feb 2025",
//                       type: Strings.checkoutdate,
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: HomeShiftCardWidget(
//                       date: "09:00 AM",
//                       type: Strings.checkouttime,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
