import 'package:flutter/material.dart';
import 'package:hidush/common/logger.dart';
import 'package:hidush/common/themes.dart';
import 'package:hidush/common/utils.dart';
import 'package:hidush/screens/app.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:hidush/common/firebase_options.dart';

final log = getLogger();

class CustomMateriaApp extends StatelessWidget {
  const CustomMateriaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: App(),
      ),
    );
  }
}

// Future<FirebaseApp>
Future<FirebaseApp> initializeFirebase() async {
  log.i("Initialzing firebase");
  return await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(const CustomMateriaApp());
}
