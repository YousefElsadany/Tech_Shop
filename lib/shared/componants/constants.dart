import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tech_shop/module/ShopLoginPage/ShopLogin.dart';
import 'package:tech_shop/shared/network/local/CachHelper.dart';
import 'package:tech_shop/shared/style/colors.dart';

//ShopLoginModel? model;
void signOut() {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      Get.offAll(LoginShopScreen());
      print('SIGN OUT SUCCESS');
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = '';

void logOut(context) {
  showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('SignOut'),
      elevation: 240.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32.0),
        ),
      ),
      // contentPadding: EdgeInsets.only(
      //   top: 10.0,
      //   left: 24.0,
      // ),
      content: Text('Do you want to sign out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: shopColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () => signOut(),
          child: const Text(
            'OK',
            style: TextStyle(
              color: shopColor,
            ),
          ),
        ),
      ],
    ),
  );
}




// Widget customCategoriesItems(DataModel model) => Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           CachedNetworkImage(
//             imageUrl: model.image!,
//             errorWidget: (context, url, error) => Icon(Icons.error),
//             height: 100.0,
//             width: 100.0,
//             fit: BoxFit.cover,
//           ),
//           Container(
//               color: Colors.black.withOpacity(0.8),
//               width: 100.0,
//               child: Text(
//                 model.name!,
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//                 textAlign: TextAlign.center,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ))
//         ],
//       );
// class MapsPage extends StatefulWidget {
//   @override
//   State<MapsPage> createState() => _MapsPageState();
// }
//
// class _MapsPageState extends State<MapsPage> {
//   Completer<GoogleMapController> _controller = Completer();
//
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//
//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: GoogleMap(
//         mapType: MapType.satellite,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: Text('To the lake!'),
//         icon: Icon(Icons.directions_boat),
//       ),
//     );
//   }
//
//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }



// Future<void> _launchUrl(bool isDir, double lat, double lon) async {
//   String url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
//
//   if (isDir) {
//     url = 'https://www.google.com/maps/dir/?api=1&origin=Googleplex&destination=$lat,$lon';
//   }
//
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
//
// Widget mapToolBar() {
//   return Row(
//     children: [
//       FloatingActionButton(
//         child: Icon(Icons.map),
//         backgroundColor: Colors.blue,
//         onPressed: () {
//           _launchUrl(false, 37.43296265331129, -122.08832357078792);
//         },
//       ),
//       FloatingActionButton(
//         child: Icon(Icons.directions),
//         backgroundColor: Colors.blue,
//         onPressed: () {
//           _launchUrl(true, 37.43296265331129, -122.08832357078792);
//           },
//       ),
//     ],
//   );
// }




// Future<Position?> determinePosition() async {
//   LocationPermission permission;
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location Not Available');
//     }
//   } else {
//     throw Exception('Error');
//   }
//   return await locatepostion();
// }

// Set<Polygon> myPolygon() {
//   List<LatLng> polygonCoords = [];
//   polygonCoords.add(LatLng(37.43296265331129, -122.08832357078792));
//   polygonCoords.add(LatLng(37.43006265331129, -122.08832357078792));
//   polygonCoords.add(LatLng(37.43006265331129, -122.08332357078792));
//   polygonCoords.add(LatLng(37.43296265331129, -122.08832357078792));
//
//   Set<Polygon> polygonSet = new Set();
//   polygonSet.add(Polygon(
//     polygonId: PolygonId('test'),
//     points: polygonCoords,
//     strokeWidth: 2,
//     strokeColor: Colors.red,),);
//
//   return polygonSet;
// }