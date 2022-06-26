import 'package:flutter/material.dart';
import 'package:flutter_random_menu/screens/main_screen.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Random menu generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.green[200],
        textTheme: GoogleFonts.kanitTextTheme(),
      ),
      initialRoute: '/main',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/main', page: () => const MainScreenPage()),
      ],
    );
  }
}
