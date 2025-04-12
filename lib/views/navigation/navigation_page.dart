import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/navigation/exercise/exercise_page.dart';
import 'package:flutter_application_1/views/navigation/home/home_page.dart';
import 'package:flutter_application_1/views/navigation/meals/meals_page.dart';
import 'package:flutter_application_1/views/navigation/profile/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;

  final List<Widget> pages = [
     HomePage(),
    const MealsPage(showArrowBack: false,),
    const ExercisePage(showArrowBack: false,),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: GNav(
            backgroundColor: Colors.white,
            color: const Color(0xff3A4750),
            activeColor: Colors.white,
            tabBackgroundColor: const Color(0xff289004),
            gap: 8,
            padding: const EdgeInsets.all(8),
            selectedIndex: currentIndex,
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            tabs: [
              _buildTab(Icons.home_outlined, 'Home'),
              _buildTab(Icons.restaurant_outlined, 'Meals'),
              _buildTab(Icons.fitness_center_outlined, 'Exercise'),
              _buildTab(Icons.person_outline, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  GButton _buildTab(IconData icon, String text) {
    return GButton(
      icon: icon,
      text: text,
      textStyle: GoogleFonts.roboto(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
