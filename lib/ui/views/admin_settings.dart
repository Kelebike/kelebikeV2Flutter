import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelebikev2/ui/views/sign_in.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../core/services/auth.dart';
import '../../core/services/history_service.dart';
import 'blacklist_page.dart';

class AdminSettingsScreen extends StatefulWidget {
  @override
  _AdminSettingsState createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettingsScreen> {
  User? _user = FirebaseAuth.instance.currentUser;
  final AuthService _authService = AuthService();
  final _historyService = HistoryService();
  bool _toggle = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6CA8F1),
        elevation: 0,
        title: const Text("Ayarlar"),
        centerTitle: true,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text("Kişisel"), //todo
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                onPressed: (value) {},
                leading: const Icon(Icons.person),
                title: const Text("Hesap"),
                value: Text(_user!.email.toString()),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Ortak'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.dangerous),
                title: const Text('Karaliste'),
                onPressed: (context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BlackListPage()));
                },
              ),
              SettingsTile.switchTile(
                initialValue: _toggle,
                onToggle: (bool value) {
                  setState(() {
                    _toggle = value;
                  });
                },
                leading: const Icon(Icons.notifications),
                title: const Text('Bildirimleri Aktif Et'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Çıkış'),
                onPressed: (context) {
                  _authService.signOut();
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                  _user = null;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
