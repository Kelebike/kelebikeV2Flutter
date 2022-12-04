import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelebikev2/ui/views/sign_in.dart';
import 'package:kelebikev2/ui/views/view_login.dart';
import 'core/services/localization_service.dart';
import 'firebase_options.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final User? _user = FirebaseAuth.instance.currentUser;
  bool loggedIn = false;
  @override
  Widget build(BuildContext context) {
    Widget startPage = SignIn();

    if (_user?.email == "admin") {
      startPage = ViewLogin();
    } else {
      startPage = SignIn();
    }

    var localizationController = Get.put(LocalizationController());

    return GetBuilder(
        init: localizationController,
        builder: (LocalizationController controller) {
          return MaterialApp(
            title: 'Kelebike',
            debugShowCheckedModeBanner: false,
            home: startPage,
            locale: controller.currentLanguage != ''
                ? Locale(controller.currentLanguage, '')
                : null,
            localeResolutionCallback:
                LocalizationService.localeResolutionCallBack,
            supportedLocales: LocalizationService.supportedLocales,
            localizationsDelegates: LocalizationService.localizationsDelegate,
          );
        });
  }
}
