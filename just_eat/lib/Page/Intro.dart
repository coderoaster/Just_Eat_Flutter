import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  startTime() async {
    var documentSnapshot = await firestore
        .collection("storeData")
        .doc('5b80fbe0-2741-11ec-98ad-6d31813b3c3f')
        .get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    List<dynamic> storeData = data['detail'];
    Get.toNamed("home", arguments: storeData);
  }

  void goHome() {}

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
