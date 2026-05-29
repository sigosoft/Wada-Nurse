import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:waaada_nurseapp/View/SuccessPages/ShiftAcceptedSuccessfully.dart';
import '../../Controller/ShiftDetailsController.dart';

import '../../Resource/Colors.dart';
import '../../Resource/Strings.dart';
import '../../Widget/SubmitButtonWidget.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key, required this.shiftType, required this.bookingId}) : super(key: key);
  final String shiftType; // To handle different shift types if needed
  final int bookingId;
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  GoogleMapController? mapController;
  final LatLng _initialPosition = const LatLng(
      37.7749, -122.4194); // Example coordinates
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = []; // Mock search results

  double? _latitude;
  double? _longitude;
  String _address = "Fetching location...";
  String _area = "";
  bool _isFetchingLocation = false;
  bool _isSubmitting = false;

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isFetchingLocation = true;
      _address = "Fetching location...";
      _area = "";
    });
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _address = "Location services are disabled.";
          _isFetchingLocation = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _address = "Location permissions are denied.";
            _isFetchingLocation = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _address = "Location permissions are permanently denied.";
          _isFetchingLocation = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _latitude = position.latitude;
      _longitude = position.longitude;

      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(_latitude!, _longitude!),
              zoom: 18.0,
            ),
          ),
        );
      }

      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          _latitude!,
          _longitude!,
        );
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          setState(() {
            _area = place.locality ?? place.subLocality ?? place.name ?? "";
            _address = "${place.name ?? ""}, ${place.subLocality ?? ""}, ${place.locality ?? ""}, ${place.administrativeArea ?? ""}, ${place.postalCode ?? ""}";
          });
        } else {
          setState(() {
            _address = "Latitude: $_latitude, Longitude: $_longitude";
          });
        }
      } catch (e) {
        debugPrint("Error in reverse geocoding: $e");
        setState(() {
          _address = "Latitude: $_latitude, Longitude: $_longitude";
        });
      }
    } catch (e) {
      debugPrint("Error getting location: $e");
      setState(() {
        _address = "Error fetching location.";
      });
    } finally {
      setState(() {
        _isFetchingLocation = false;
      });
    }
  }

  void _showConfirmBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  SvgPicture.asset(
                    "lib/Assets/Images/question.svg",
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    Strings.confirm,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.shiftType == "checkin" ? Strings.checkinmsg : Strings.checkoutMsg,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            onPressed: _isSubmitting
                                ? null
                                : () {
                                    Navigator.pop(bottomSheetContext);
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE7F4FD),
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
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            onPressed: _isSubmitting
                                ? null
                                : () async {
                                    setModalState(() {
                                      _isSubmitting = true;
                                    });
                                    if (widget.shiftType == "checkin") {
                                      final detailsController = Get.find<ShiftDetailsController>();
                                      bool success = await detailsController.checkIn(
                                        widget.bookingId,
                                        _latitude ?? 0.0,
                                        _longitude ?? 0.0,
                                      );
                                      setModalState(() {
                                        _isSubmitting = false;
                                      });
                                      if (success) {
                                        Navigator.pop(bottomSheetContext);
                                        Get.off(ShiftAcceptedSuccessfully(
                                          title: Strings.successfullyCheckedin,
                                          message: Strings.successfullyCheckedinmsg,
                                          bookingId: widget.bookingId,
                                        ));
                                      }
                                    } else {
                                      setModalState(() {
                                        _isSubmitting = false;
                                      });
                                      Navigator.pop(bottomSheetContext);
                                      Get.to(ShiftAcceptedSuccessfully(
                                        title: Strings.successfullyCheckedout,
                                        message: Strings.successfullyCheckedoutmsg,
                                        bookingId: widget.bookingId,
                                      ));
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: _isSubmitting
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                : Text(
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
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
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
    mapController?.setMapStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            // Google Map
            GoogleMap(
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 18.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                _setMapStyle();
                _getCurrentLocation();
              },
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _getCurrentLocation();
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
                    margin: const EdgeInsets.only(left: 10, right: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: white, size: 23,),
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
                        boxShadow: const [
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
                decoration: const BoxDecoration(
                  color: Color(0xFFEAEAEA),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 5,),
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
                              child: Text(
                                _area.isNotEmpty ? _area : "Current Location",
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 80,
                              child: Text(
                                _address,
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
      ),
    );
  }
}