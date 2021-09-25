import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<double> _x = [
  37.5656881134626,
  37.5556881134625,
  37.5456881134624,
  37.5356881134623,
  37.5256881134622,
  37.5156881134621
];
List<double> _y = [
  126.97714692170688,
  126.97714692170687,
  126.97714692170686,
  126.97714692170685,
  126.97714692170684,
  126.97714692170683
];
List<Marker> _markers = [];
int test = 0;

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

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _y.length; i++) {
      _markers.add(Marker(
          markerId: MarkerId("$i"),
          draggable: true,
          onTap: () {
            test = i;
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50))),
                context: context,
                builder: buildBottomSheet);
          },
          position: LatLng(_x[i], _y[i])));
    }
  }
}

Widget buildBottomSheet(BuildContext context) {
  double y = _y[test];
  double x = _x[test];
  return Container(
    child: Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Text("Y좌표 : $y"),
        Text("X좌표 : $x")
      ],
    ),
  );
}
