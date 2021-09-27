import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:just_eat/Page/Home.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  startTime() async {
    var documentSnapshot =
        await firestore.collection("data").doc('store').get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    List<dynamic> data2 = data['detail'];
    print("test ${data2.length}");
    print("test : ${data.length}");
    Get.toNamed("home", arguments: data);
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

// class IntroPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference users = FirebaseFirestore.instance.collection('data');
//     print("test : ${users.get()}");
//    return Container();
// }
//  return FutureBuilder<DocumentSnapshot>(
//       future: users.doc("store").get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }

//         if (snapshot.hasData && !snapshot.data!.exists) {
//           return Text("Document does not exist");
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data =
//               snapshot.data!.data() as Map<String, dynamic>;
//           return Text("Full Name: ${data}");
          
//         }
//         return Text("loading");
        
//       },
      
//     );
    
//   }
  