import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelebikev2/ui/views/user_main_page.dart';
import 'package:kelebikev2/ui/views/user_settings.dart';
import '../../core/services/auth.dart';
import '../../core/services/bike_service.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 1;
  int data = 0;

  final screens = [
    const HistoryScreen(),
    UserInfoPage(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    BikeService _bikeService = BikeService();
    return Scaffold(
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Colors.orange.shade100,
              labelTextStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              )),
          child: NavigationBar(
            height: 60,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            animationDuration: const Duration(milliseconds: 500),
            selectedIndex: index,
            onDestinationSelected: (int index) => setState(() {
              this.index = index;
            }),
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.history_outlined),
                  selectedIcon: Icon(Icons.history),
                  label: 'History'),
              NavigationDestination(
                  icon: Icon(Icons.home),
                  selectedIcon: Icon(Icons.home_outlined),
                  label: 'Home'),
              NavigationDestination(
                  icon: Icon(Icons.settings),
                  selectedIcon: Icon(Icons.settings_outlined),
                  label: 'Settings'),
            ],
          ),
        ));
  }
}
