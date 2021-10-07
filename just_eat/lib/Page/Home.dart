import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui';

List<Marker> _markers = [];
int seq = 0;
bool check = false;
List<dynamic> storeData = Get.arguments;

class PageHome extends StatefulWidget {
  @override
  State<PageHome> createState() => GooleMapPage();
}

class GooleMapPage extends State<PageHome> {
  late Uint8List markerIcon;
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.56560879490811, 126.9768763757379),
    zoom: 10,
  );

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    markerIcon = await getBytesFromAsset('images/customMarker.png', 130);
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
    for (int i = 0; i < storeData.length; i++) {
      _markers.add(Marker(
          markerId: MarkerId("$i"),
          draggable: true,
          icon: BitmapDescriptor.fromBytes(markerIcon),
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
  String img = storeData[seq]["img"];
  String holiday = storeData[seq]["holiday"];
  String youtube = storeData[seq]["youtube"];
  return SingleChildScrollView(
      child: Container(
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Container(
          width: 300,
          height: 300,
          child: Image.network(
            "$img",
            fit: BoxFit.contain,
          ),
        ),
        Text("가게이름 : $name"),
        Text("주소 : $address"),
        Text("전화번호 : $tell"),
        Text("영업시간 : $time"),
        Text("휴무일 : $holiday"),
        Text("SNS : $url"),
        Text("유튜브 : $youtube"),
        SizedBox(
          height: 50,
        ),
      ],
    ),
  ));
}
