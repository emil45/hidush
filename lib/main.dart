import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hidush/screens/authenticate/authenticate.dart';
// import 'package:hidush/screens/navigation_app.dart';
import 'firebase_options.dart';
// import 'package:hidush/screens/authenticate/authenticate.dart';

class CustomMateriaApp extends StatelessWidget {
  const CustomMateriaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Authenticate();
    // return const MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: Directionality(
    //     textDirection: TextDirection.rtl,
    //     child: NavigationApp(),
    //   ),
    // );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const CustomMateriaApp());
}
