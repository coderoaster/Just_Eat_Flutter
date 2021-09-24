import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'Page/Home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    title: "Just_Eat",
    initialRoute: '/home',
    getPages: pages,
    // home: MapSample(),
  ));
}

final pages = [
  GetPage(
    name: '/home',
    transition: Transition.fade,
    page: () => PageHome(),
  ),
];
