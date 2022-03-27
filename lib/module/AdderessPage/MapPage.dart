import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:tech_shop/shared/style/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';


class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}
class _MapsPageState extends State<MapsPage> {
  var markers = HashSet<Marker>();
  Position? currentpositon;
  bool _selectedIndex = false;
  LatLng markerPosition = LatLng(
    30.0444,
    31.2357,);
  Completer<GoogleMapController> newGoogleMapController = Completer();
  List<Marker> allMarkers =[

    Marker(
      infoWindow: InfoWindow(
          title: 'Suez Brunch',
        snippet: '23-Jul, Suez, Suez Governorate',
      ),
      markerId: MarkerId('firstMarker'),
      position:LatLng(29.96636821088315, 32.5539861903579),
    ),
    Marker(
      infoWindow: InfoWindow(
          title: 'Al Arbaeen Brunch',
        snippet: 'XGGX+3H3, Arbaeen, Suez Governorate',
      ),
      markerId: MarkerId('secondMarker'),
      position:LatLng(29.975054906390735, 32.548988328142755),
    ),
    Marker(
      // icon: myCustomIcon,
      onTap: (){
        print('this is the user location .,');
      },
      infoWindow: InfoWindow(
  title: 'Al Salam 2 Branch',
  snippet: 'Al-Salam, in front of Suez University, Al-Yusab Mall, Suez, Suez Governorate',
  ),
      markerId: MarkerId('third'),
      position:LatLng(29.99144063259145, 32.49473137298715),
    ),

    Marker(
      // icon: BitmapDescriptor.defaultMarker,
      onTap: (){
        print('this is the last location .,');
      },
      infoWindow: InfoWindow(
          title: 'Heliopolis Brunch',
        snippet: '34 Ahmed Farid, Al Matar, El Nozha, Cairo Governorate',
      ),
      markerId: MarkerId('last'),
      position:LatLng(30.10983190983805, 31.335361462881977),
    ),

  ];
  @override
  void initState() {
    super.initState();
    locatepostion();
    print(locatepostion.toString());


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fullBackgroundColor,
      appBar: AppBar(
        title: Text('Our Brunches'),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: fullBackgroundColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: fullBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: shopColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
           // polygons: myPolygon() as Set<Polygon>,
            mapType: MapType.hybrid,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  // 37.43296265331129, -122.08832357078792
                30.0444,
                31.2357,
              ),
              zoom: 14.0,
            ),
            onMapCreated: (googleMapController) {
              newGoogleMapController.complete(googleMapController);
              setState(() {
                markers.addAll(
                    allMarkers,

                );
                markers.add(
                  Marker(
                    markerId: MarkerId('1'),
                    position:LatLng(
                        30.0444,
                        31.2357,
                    ),
                    infoWindow: InfoWindow(
                      title: 'Work Place',
                      snippet: 'build 27 - 162 street - kafr ahmed abdo algded ',
                    ),
                    onTap: (){},
                  ),
                );

              });
            },
            markers: markers,
          ),
          //mapToolBar(),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton.extended(
                    heroTag: "btn1",
                    onPressed: ()  {
                      determinePosition();
                      myPosition();
                      print(currentpositon.toString());
                      if (currentpositon != null) {
                        setState(() {
                          markers.add(
                            Marker(
                              markerId: MarkerId('2'),
                              position: LatLng(currentpositon!.latitude, currentpositon!.longitude),
                              infoWindow: InfoWindow(
                                title: 'Work Place',
                                snippet: 'build 27 - 162 street - kafr ahmed abdo algded ',
                              ),
                              onTap: (){},
                            ),
                          );
                        });
                        //markerPosition =  LatLng(currentpositon!.latitude, currentpositon!.longitude);
                      }

                    },
                      label: Icon(Icons.my_location,color: shopColor,),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Colors.white,
                    //icon: const Icon(Icons.map, size: 30.0),
                  ),
                ),

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 110),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(

                heroTag: "btn2",
                onPressed: ()  {
                  Get.bottomSheet(
                      Container(
                        color: Colors.white,
                        child: new Flexible(
                            child: ListView.builder(
                              itemCount: allMarkers.length,
                              padding: EdgeInsets.all(4.0),
                              itemBuilder: (context, index) {
                                return Card(
                                    color: _selectedIndex != null && _selectedIndex == index
                                        ? Colors.greenAccent
                                        : Colors.white,
                                    child: ListTile(
                                      onTap: () {
                                        ourBranches(
                                          allMarkers[index].markerId,
                                          allMarkers[index].infoWindow.title,
                                          allMarkers[index].infoWindow.snippet,
                                          allMarkers[index].position.latitude,
                                          allMarkers[index].position.longitude,
                                        );
                                        // _onSelected(index);
                                      },
                                      title: Text(
                                        allMarkers[index].infoWindow.title.toString() ,
                                        style: TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                      trailing: Container(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.blue,

                                            ),
                                            onPressed: () => MapsLauncher.launchQuery(
                                              allMarkers[index].infoWindow.snippet.toString(),),
                                            child: Icon(Icons.assistant_navigation),
                                          )),
                                      subtitle: Text(allMarkers[index].infoWindow.snippet.toString()),
                                    ));
                              },
                            )),
                      )
                  );
                },
                label: Row(
                  children: [
                    Icon(Icons.list_outlined,color:shopColor,),
                    SizedBox(width: 5.0,),
                    Text('List',style: TextStyle(color: shopColor),),
                  ],
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: Colors.white,
                //icon: const Icon(Icons.map, size: 30.0),
              ),
            ),
          ),
        ],
      ),

    );
  }
  Future<void> locatepostion() async{
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentpositon=position;  // this is line 26, it is point before await
  }
  Future<void> myPosition() async{
    LatLng latLngPosition=LatLng(currentpositon!.latitude,currentpositon!.longitude);

    CameraPosition cameraPosition=new CameraPosition(target: latLngPosition,zoom: 14);
    final GoogleMapController controller = await newGoogleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
  Future<void> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      return locatepostion();
    }
  }

  Future<void> ourBranches(id, name,address, lat, lng) async {
    final GoogleMapController controller = await newGoogleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 16.0)));
    setState(() {
      markers.add(Marker(
        markerId: MarkerId(id),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: name,
          snippet: address,
        ),
        onTap: () {
          //_pageController.jumpToPage(i);
        },
        icon: BitmapDescriptor.defaultMarker,
      ));
      print(MarkerId(id));
      controller.showMarkerInfoWindow(MarkerId(id));
    });
  }

}


