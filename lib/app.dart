import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nanostorm/ui/pages/login/splash.dart';
import 'package:nanostorm/ui/themes/ns_theme.dart';
import 'package:nanostorm/ui/widgets/ns_circular_progress.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alloy',
      theme: NSTheme().theme,
      home: Splash(),
      routes: <String, WidgetBuilder>{
        '/main': (BuildContext context) => App(),
      },
    );
  }
}