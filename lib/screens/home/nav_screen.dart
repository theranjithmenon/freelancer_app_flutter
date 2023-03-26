import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainNavScreen extends StatelessWidget {
  const MainNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Colors.amberAccent,
        bottomNavigationBar: Container(
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(25)),
      child: GNav(
          onTabChange: (value) {},
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          gap: 10,
          tabs: const [
            GButton(
              icon: Icons.home_filled,
              text: 'Home',
            ),
            GButton(
              icon: Icons.chat_bubble_rounded,
              text: 'Chats',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ]),
    ));
  }
}
