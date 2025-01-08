import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(bool value) {
    setState(() {
      _themeMode = value ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: HomePage(
        toggleTheme: _toggleTheme, // Pass the toggleTheme function
        themeMode: _themeMode, // Pass the current theme mode
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final void Function(bool) toggleTheme; // Accept a function that takes a bool
  final ThemeMode themeMode; // Receive the current theme mode

  const HomePage({Key? key, required this.toggleTheme, required this.themeMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "9:41",
                  style: TextStyle(fontSize: 18),
                ),
                const Icon(Icons.wifi),
                const Icon(Icons.battery_full),
              ],
            ),
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/office_girl.jpg'),

            ),
            const SizedBox(height: 20),
            const Text(
              "Ahlam Orakzai",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            _buildListTile(
              icon: Icons.phone,
              title: "Phone",
              subtitle: "+92 345678 9",
            ),
            _buildListTile(
              icon: Icons.mail,
              title: "Mail",
              subtitle: "ahlamorakzai@gmail.com",
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  _buildSettingsTile(
                    icon: Icons.brightness_4,
                    title: "Dark mode",
                    isSwitch: true,
                    onSwitchChanged: toggleTheme, // Pass the function to the switch
                    themeMode: themeMode, // Pass the themeMode to check current theme
                  ),
                  _buildSettingsTile(
                    icon: Icons.person,
                    title: "Profile details",
                  ),
                  _buildSettingsTile(
                    icon: Icons.settings,
                    title: "Settings",
                  ),
                  _buildSettingsTile(
                    icon: Icons.logout,
                    title: "Log out",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    bool isSwitch = false,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: isSwitch
          ? Switch(
        value: themeMode == ThemeMode.dark, // Use passed themeMode to check the current theme
        onChanged: (value) {}, // You don't need to handle onChanged here
      )
          : null,
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    bool isSwitch = false,
    void Function(bool)? onSwitchChanged, // Adjusted to accept a function with a bool parameter
    ThemeMode? themeMode,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: isSwitch
          ? Switch(
        value: themeMode == ThemeMode.dark, // Use passed themeMode to check the current theme
        onChanged: onSwitchChanged, // Call the provided function
      )
          : null,
    );
  }
}
