import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hidush/models/user.dart';
import 'package:hidush/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class Personal extends StatefulWidget {
  Personal({Key? key}) : super(key: key);

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  final AuthService _authService = AuthService();
  bool switchState = false;

  void setSwich() => switchState = !switchState;

  @override
  Widget build(BuildContext context) {
    final AuthenticatedUser? user = Provider.of<AuthenticatedUser?>(context);

    return SettingsList(
      lightTheme: const SettingsThemeData(settingsListBackground: Colors.white),
      sections: [
        SettingsSection(
          title: const Text('משתמש'),
          tiles: <SettingsTile>[
            SettingsTile(
              leading: const Icon(Icons.email),
              title: Text('${user?.email}'),
              onPressed: (value) {
                Clipboard.setData(ClipboardData(text: '${user?.email}'));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('המייל מועתק'),
                ));
              },
            ),
            SettingsTile(
              leading: const Icon(Icons.logout),
              title: const Text('התנתק'),
              onPressed: (value) async => _authService.signOut(),
            ),
          ],
        ),
        SettingsSection(
          title: const Text('הגדרות'),
          tiles: <SettingsTile>[
            SettingsTile.switchTile(
              leading: const Icon(Icons.settings),
              title: const Text('סתם לצחוקים'),
              onPressed: (value) async => null,
              initialValue: switchState,
              onToggle: (bool value) =>
                  setState(() => switchState = !switchState),
            ),
          ],
        ),
      ],
    );
  }
}
