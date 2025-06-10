import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/View/Wallet/Wallet.dart';

import '../../Resource/Strings.dart';
import '../Bookings/Bookings.dart';
import 'HomeItem.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeItem(),
    Bookings(),
    Wallet(),
    HomeItem(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false; // Prevent default back button behavior
        }
        return true; // Allow default back button behavior
      },
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          selectedLabelStyle: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 0
                    ? "lib/Assets/Images/home_selected.svg"
                    : "lib/Assets/Images/home_unselected.svg",
                fit: BoxFit.scaleDown,
              ),
              label: Strings.home,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 1
                    ? "lib/Assets/Images/bookings_selected.svg"
                    : "lib/Assets/Images/bookings_unselected.svg",
                fit: BoxFit.scaleDown,
              ),
              label: Strings.bookings,
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? SvgPicture.asset(
                "lib/Assets/Images/wallet_unselected.svg",
                fit: BoxFit.scaleDown,
                color: colorPrimary,
              )
                  : SvgPicture.asset(
                "lib/Assets/Images/wallet_unselected.svg",
                fit: BoxFit.scaleDown,
              ),
              label: Strings.wallet,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 3
                    ? "lib/Assets/Images/profile_selected.svg"
                    : "lib/Assets/Images/profile_unselected.svg",
                fit: BoxFit.scaleDown,
              ),
              label: Strings.profile,
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}