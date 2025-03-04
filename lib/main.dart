import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

/*
 <script

   src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCkIoq-G28WGsdcBikXsq5HzE48MlIsSic&libraries=drawing,visualization,places" -->
  </script>
   
 */

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 12.4746,
  );

  final List<Marker> _markers = [];
  final List<Marker> _locations = [
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(37.42796133580664, -122.085749655962),
      infoWindow: InfoWindow(
        title: 'My Location',
      ),
    ),
    const Marker(
      markerId: MarkerId('2'),
      position: LatLng(37.82796133580664, -122.045749655962),
      infoWindow: InfoWindow(
        title: 'My Friend',
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _markers.addAll(_locations);
  }



  _buildMap() {
    return Container(
      height: 400,
      width: 500,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
      child: GoogleMap(
        mapType: MapType.hybrid,
        markers: Set<Marker>.of(_markers),
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(child: _buildMap()),
        Positioned(
          bottom: 30,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return MouseRegion(
                  child: Card(
                    child: Image.asset(
                      'Assets/Images/america.jpg',
                    ),
                  ),
                );
              }),
        )
      ],
    ));
  }
  /*
  final ScrollController _scrollController = ScrollController();

  double mapHeight =
      0.7; // Initial map height as a fraction of the screen height
  double maxListHeight =
      0.5; // Maximum list height as a fraction of the screen height

  // ... existing code ...

  _buildMap() {
    return Container(
      height: MediaQuery.of(context).size.height * mapHeight,
      width: double.infinity,
      child: GoogleMap(
        mapType: MapType.hybrid,
        markers: Set<Marker>.of(_markers),
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  _updateMapHeight() {
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double currentScrollExtent = _scrollController.position.pixels;
    double scrollPercentage = currentScrollExtent / maxScrollExtent;

    // Calculate the new map height based on scroll percentage and maximum list height
    double newMapHeight = 0.4 + scrollPercentage * (maxListHeight - 0.4);

    setState(() {
      mapHeight =
          newMapHeight.clamp(0.4, 0.7); // Clamp the height between 0.4 and 0.7
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateMapHeight);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildMap(),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) {
                return MouseRegion(
                  child: Card(
                    child: Image.asset('Assets/Images/america.jpg'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  */
}
