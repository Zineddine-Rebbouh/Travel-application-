import 'package:flutter/material.dart';
import 'package:travel_app/pages/favouritess.dart';
import 'package:travel_app/pages/Home_page.dart';
import 'package:travel_app/pages/profile_page.dart';
import 'package:travel_app/pages/notification.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of pages corresponding to each icon
  final List<Widget> _pages = [
    HomeScreen(),
    ExploreScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(
            255, 255, 137, 26), // Set the color for selected item (icons)
        unselectedItemColor:
            Colors.grey, // Set the color for unselected items (labels)
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 25,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 25,
            ),
            label: 'Liked',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 25,
            ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_rounded,
              size: 25,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
