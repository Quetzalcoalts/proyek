import 'package:flutter/material.dart';

import 'Profile-Page.dart';
import 'main.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int current_index_navbar = 1;
  final screen_navbar = [
    const MyApp(),
    //LoginPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white24,
          iconSize: 28,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedFontSize: 12,
          currentIndex: current_index_navbar,
          onTap: (index) => setState(() {
            current_index_navbar = index;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue,
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.no_drinks),
            //   label: 'Nothing',
            //   backgroundColor: Colors.blue,
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Profile',
              backgroundColor: Colors.blue,
            ),
          ],
        ),
        body: IndexedStack(
          index: current_index_navbar,
          children: screen_navbar,
        ));
  }
}
