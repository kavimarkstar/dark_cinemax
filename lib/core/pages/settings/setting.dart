import 'package:dark_cinemax/core/pages/settings/navigation/theme_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: SingleChildScrollView(child: Column(children: [ThemeChange()])),
    );
  }
}
