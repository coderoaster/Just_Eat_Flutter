import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Marker> _markers = [];
int seq = 0;
bool check = false;
List<dynamic> storeData = Get.arguments;

class PageHome extends StatefulWidget {
  @override
  State<PageHome> createState() => GooleMapPage();
}

class GooleMapPage extends State<PageHome> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.56560879490811, 126.9768763757379),
    zoom: 10,
  );

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < storeData.length; i++) {
      _markers.add(Marker(
          markerId: MarkerId("$i"),
          draggable: true,
          infoWindow: InfoWindow(
              title: storeData[i]['name'],
              onTap: () {
                seq = i;
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(50))),
                    context: context,
                    builder: buildBottomSheet);
              }),
          onTap: () {
            if (check) {
              seq = i;
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(50))),
                  context: context,
                  builder: buildBottomSheet);
              check = !check;
            } else {
              check = !check;
            }
          },
          position: LatLng(storeData[i]['x'], storeData[i]['y'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: Set.from(_markers),
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}

Widget buildBottomSheet(BuildContext context) {
  String name = storeData[seq]["name"];
  String address = storeData[seq]["address"];
  String url = storeData[seq]["url"];
  String tell = storeData[seq]["tell"];
  String time = storeData[seq]["time"];
  return Container(
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Container(
          width: 300,
          height: 300,
          child: Image.network(
            "$url",
            fit: BoxFit.contain,
          ),
        ),
        Text("가게이름 : $name"),
        Text("주소 : $address"),
        Text("전화번호 : $tell"),
        Text("영업시간 : $time")
      ],
    ),
  );
}
