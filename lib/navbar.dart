import 'package:flutter/material.dart';

import 'Profile-Page.dart';
import 'main.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int current_index_navbar = 0;
  final screen_navbar = [
    MyApp(),
    //LoginPage(),
    ProfilePage(),
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
          items: [
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
        
        appBar: AppBar(
          backgroundColor: Colors.grey,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), onPressed: (){},
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: (){},),
            IconButton(icon: Icon(Icons.shopping_cart_outlined), onPressed: (){},)
          ],
        ),
        body: IndexedStack(
          index: current_index_navbar,
          children: screen_navbar,
        ));
  }
}
