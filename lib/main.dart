import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

import 'internal/application.dart';
import 'locator/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  setup();

  if (!kIsWeb) {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }

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
