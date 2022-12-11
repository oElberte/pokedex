import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var darkMode = Hive.box('themeData').get('darkmode');

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Dark mode",
                    style: TextStyle(fontSize: 18),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Switch.adaptive(
                      value: darkMode ?? false,
                      onChanged: (value) {
                        setState(
                          () {
                            Hive.box('themeData').put('darkmode', value);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
