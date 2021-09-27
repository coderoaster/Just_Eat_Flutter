import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'Page/Home.dart';
import 'Page/Intro.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    title: "Just_Eat",
    initialRoute: '/intro',
    getPages: pages,
  ));
}

final pages = [
  GetPage(
    name: '/home',
    transition: Transition.fade,
    page: () => PageHome(),
  ),
  GetPage(
    name: '/intro',
    page: () => IntroPage(),
    transition: Transition.fade,
  )
];
