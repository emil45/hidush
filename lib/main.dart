import 'package:flutter/material.dart';
import 'package:hidush/common/themes.dart';
import 'package:hidush/models/user.dart';
import 'package:hidush/screens/app.dart';
import 'package:hidush/services/auth.dart';
import 'package:provider/provider.dart';

class CustomMateriaApp extends StatelessWidget {
  const CustomMateriaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthenticatedUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const Directionality(
          textDirection: TextDirection.rtl,
          child: App(),
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.initializeFirebase();
  runApp(const CustomMateriaApp());
}
