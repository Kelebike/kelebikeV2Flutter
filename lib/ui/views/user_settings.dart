import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kelebikev2/ui/views/sign_in.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../core/services/auth.dart';
import '../../core/services/localization_service.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

String currentLanguage(String lang) {
  if (lang == "tr") {
    return "Türkçe";
  } else if (lang == "en") {
    return "English";
  } else {
    return "Change language";
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  User? _user = FirebaseAuth.instance.currentUser;
  final AuthService _authService = AuthService();
  final localizationController = Get.find<LocalizationController>();
  bool _toggle = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      color: const Color.fromARGB(255, 201, 226, 101),
      child: SettingsList(
        sections: [
          SettingsSection(
            title: const Text("Personal"), //todo
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                onPressed: (value) {},
                leading: const Icon(Icons.person),
                title: Text(LocalizationService.of(context).translate('acnt')!),
                value: Text(_user!.email.toString()),
              ),
            ],
          ),
          SettingsSection(
            title: Text(LocalizationService.of(context).translate('common')!),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                onPressed: (value) {
                  localizationController.toggleLanguage();
                },
                leading: Icon(Icons.language),
                title: Text(
                    LocalizationService.of(context).translate('language')!),
                value: Text(currentLanguage(
                    localizationController.currentLanguage.toString())),
              ),
              SettingsTile.switchTile(
                initialValue: _toggle,
                onToggle: (bool value) {
                  setState(() {
                    _toggle = value;
                  });
                },
                leading: const Icon(Icons.notifications),
                title: Text(
                    LocalizationService.of(context).translate('enable_not')!),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.exit_to_app),
                title: Text(
                    LocalizationService.of(context).translate('sign_out')!),
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
