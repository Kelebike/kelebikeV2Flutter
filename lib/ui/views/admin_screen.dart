import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/services/auth.dart';
import '../../core/services/bike_service.dart';
import 'admin_bikes_screen.dart';
import 'admin_history_screen.dart';
import 'admin_info_page.dart';
import 'admin_requests_screen.dart';
import 'admin_settings.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final AuthService _authService = AuthService();

  int index = 2;

  final screens = [
    AdminHistoryScreen(),
    AdminBikesScreen(),
    AdminInfoPage(),
    RequestScreen(),
    AdminSettingsScreen()
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
          onDestinationSelected: (int index) =>
              setState(() => this.index = index),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.history_outlined),
                selectedIcon: Icon(Icons.history),
                label: 'Geçmiş'),
            NavigationDestination(
                icon: Icon(Icons.pedal_bike),
                selectedIcon: Icon(Icons.pedal_bike),
                label: 'Bisikletler'),
            NavigationDestination(
                icon: Icon(Icons.home),
                selectedIcon: Icon(Icons.home_outlined),
                label: 'Ana Sayfa'),
            NavigationDestination(
                icon: Icon(Icons.call_received),
                selectedIcon: Icon(Icons.call_received),
                label: 'İstekler'),
            NavigationDestination(
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings_outlined),
                label: 'Ayarlar'),
          ],
        ),
      ),
    );
  }
}
