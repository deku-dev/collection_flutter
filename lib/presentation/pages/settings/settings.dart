import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_notifier.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _areNotificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _areNotificationsEnabled = prefs.getBool('areNotificationsEnabled') ?? true;
    });
  }

  Future<void> _saveNotificationsSetting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('areNotificationsEnabled', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              // _SingleSection(
              //   title: "Account",
              //   children: [
              //     _CustomListTile(
              //       title: "Account Information",
              //       icon: Icons.person,
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (context) => const AccountInfoPage()),
              //         );
              //       },
              //     ),
              //     _CustomListTile(
              //       title: "Logout",
              //       icon: Icons.exit_to_app,
              //       onTap: () {
              //         // Handle logout functionality here
              //       },
              //     ),
              //   ],
              // ),
              _SingleSection(
                title: "Notifications",
                children: [
                  _CustomListTile(
                    title: "Enable Notifications",
                    icon: Icons.notifications,
                    trailing: Switch(
                      value: _areNotificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _areNotificationsEnabled = value;
                        });
                        _saveNotificationsSetting(value);
                      },
                    ),
                  ),
                ],
              ),
              _SingleSection(
                title: "App Theme",
                children: [
                  _CustomListTile(
                    title: "Dark Mode",
                    icon: Icons.brightness_6,
                    trailing: BlocBuilder<ThemeCubit, bool>(
                      builder: (context, isDarkMode) {
                        return Switch(
                          value: isDarkMode,
                          onChanged: (value) {
                            context.read<ThemeCubit>().toggleTheme();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _CustomListTile({
    Key? key,
    required this.title,
    required this.icon,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}