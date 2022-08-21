import 'package:alquranapp/router/router_app.dart';
import 'package:alquranapp/router/router_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Al-Quran App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: LoginScreenViewRoute,
      getPages: AppPages.pages,
    );
  }
}