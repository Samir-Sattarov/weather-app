import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:permission_handler/permission_handler.dart';

import 'internal/application.dart';
import 'locator/locator.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();


  setup();

  if (!kIsWeb) {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }

  await Permission.location.request();
  await Geolocator.requestPermission();



  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ru'),
        // Locale('en'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru'),
      child: const Application(),
    ),
  );
}
