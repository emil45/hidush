import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hidush/common/const.dart';
import 'package:hidush/models/user.dart';
import 'package:hidush/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class Personal extends StatefulWidget {
  const Personal({Key? key}) : super(key: key);

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
                  content: Text('הועתק'),
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
              leading: const Icon(Icons.invert_colors),
              title: const Text('מצב לילה'),
              onPressed: (value) async => null,
              initialValue: switchState,
              onToggle: (bool value) => setState(() => switchState = !switchState),
            ),
          ],
        ),
        SettingsSection(
          title: const Text('אודות'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.contact_support),
              title: const Text('צור קשר'),
              value: Text(contactUsEmail),
              onPressed: (value) {
                Clipboard.setData(ClipboardData(text: contactUsEmail));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('הועתק'),
                ));
              },
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.balance),
              title: const Text('תקנון'),
              onPressed: (value) {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    context: context,
                    builder: (BuildContext builder) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Container(
                              height: 4,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.6),
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: FutureBuilder(
                                future: rootBundle.loadString('assets/texts/terms.txt'),
                                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(snapshot.data.toString()),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
            ),
            SettingsTile(
              leading: const Icon(Icons.smart_toy),
              title: const Text('גירסא'),
              value: Text(version),
            ),
          ],
        ),
      ],
    );
  }
}
