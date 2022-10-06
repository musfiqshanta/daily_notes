import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/pages/note_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xff34495e),
          primaryColor: Colors.black,
          appBarTheme: AppBarTheme(backgroundColor: Colors.transparent)),
      home: SafeArea(child: NotePage()),
    );
  }
}
