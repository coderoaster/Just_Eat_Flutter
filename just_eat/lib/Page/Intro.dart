import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
    Uint8List markerIcon = await getBytesFromAsset("assets/icon/icPin.png", 50);
    Get.offAndToNamed("home",
        arguments: {"data": storeData, "marker": markerIcon});
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  // 커스텀 마커 이미지 적용
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.white,
                  child: Image.asset("assets/images/imgSplash.png"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
