import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:waaada_nurseapp/View/SuccessPages/ShiftAcceptedSuccessfully.dart';

import '../../Resource/Colors.dart';
import '../../Resource/Strings.dart';
import '../../Widget/SubmitButtonWidget.dart';
import '../Home/Home.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  late GoogleMapController mapController;
  final LatLng _initialPosition = const LatLng(
      37.7749, -122.4194); // Example coordinates
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = []; // Mock search results

  void _showConfirmBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              SvgPicture.asset(
                "lib/Assets/Images/question.svg",
                // Replace with your SVG path
                width: 40,
                height: 40,
              ),
              SizedBox(height: 5),
              Text(
                Strings.confirm,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                Strings.checkinmsg,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE7F4FD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          Strings.no,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colorPrimaryDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(ShiftAcceptedSuccessfully(title: Strings.successfullyCheckedin,message: Strings.successfullyCheckedinmsg));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          Strings.yes,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _onSearchChanged(String query) {
    // Mock search logic
    setState(() {
      _searchResults = query.isEmpty
          ? []
          : List.generate(5, (index) => "$query Result $index");
    });
  }

  @override
  void initState() {
    super.initState();
    // _setMapStyle();
  }

  void _setMapStyle() async {
    String style = '''
  [
    {
      "featureType": "all",
      "elementType": "labels",
      "stylers": [
        { "visibility": "off" }
      ]
    }
  ]
  ''';
    mapController.setMapStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 18.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              _setMapStyle();
            },
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                // Add your location button logic here
              },
              child: SvgPicture.asset(
                'lib/Assets/Images/locationbutton.svg', // Path to your SVG file
                width: 80,
                height: 80,
              ),
            ),
          ),
          // Search Bar
          Positioned(
            top: MediaQuery
                .of(context)
                .padding
                .top + 10,
            left: 10,
            right: 10,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: white, size: 23,),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          cursorColor: white,
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          decoration: InputDecoration(
                            hintText: Strings.searchplace,
                            hintStyle: GoogleFonts.inter(
                              color: white,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                          ),
                          style: GoogleFonts.inter(
                            color: white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Dropdown for search results
                if (_searchResults.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: SvgPicture.asset(
                            'lib/Assets/Images/locationIcon.svg',
                            // Path to your SVG file
                            width: 20,
                            height: 20,
                          ),
                          title: Text(
                            _searchResults[index],
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            // Handle search result selection
                            print("Selected: ${_searchResults[index]}");
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          // Bottom Container
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xFFEAEAEA),
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'lib/Assets/Images/locationIcon.svg',
                        // Path to your SVG file
                        width: 23,
                        height: 23,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 80,
                            child:
                            Text(
                              "Rajpur",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),),
                          SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 80,
                            child: Text(
                              "7J3H+2RG Raipur, Chhattisgarh",
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SubmitButtonWidget(
                    onTap: () {
                      _showConfirmBottomSheet(context);
                    },
                    text: Strings.verifylocation,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}