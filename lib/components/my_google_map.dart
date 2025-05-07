// only infoWindow
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../components/google_map_data.dart';
import '../utils/global_others.dart';

class MyGoogleMap extends StatefulWidget {
  const MyGoogleMap({super.key});

  @override
  MyGoogleMapState createState() => MyGoogleMapState();
}

class MyGoogleMapState extends State<MyGoogleMap> {
  late GoogleMapController mapController;
  final String googleMapsApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
  final LatLng _center = const LatLng(48.8566, 2.3522); // Paris
  Set<Marker> _markers = {}; 

  // Variables controlling the custom InfoWindow visibility and content
  bool _isInfoWindowVisible = false;
  String _infoWindowTitle = "";
  String _infoWindowDescription = "";
  String _infoWindowImage = "";
  Offset _infoWindowOffset = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
  }

  // Converts a LatLng position into screen coordinates (pixels) 
  Future<Offset> _convertLatLngToScreen(LatLng position) async {
    ScreenCoordinate screenCoordinate = await mapController.getScreenCoordinate(position);
    return Offset(screenCoordinate.x.toDouble(), screenCoordinate.y.toDouble());
  }

  // Creates a custom marker icon from an image asset
  Future<BitmapDescriptor> _createCustomMarker(String imagePath) async {
    return BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(24, 38)),
      imagePath,
    );
  }

  // Displays the custom InfoWindow at the correct screen position
  void _showCustomInfoWindow(LatLng position, String title, String description, String image) async {
    Offset screenPosition = await _convertLatLngToScreen(position);

    setState(() {
      _isInfoWindowVisible = true;
      _infoWindowTitle = title;
      _infoWindowDescription = description;
      _infoWindowImage = image;
      _infoWindowOffset = screenPosition; // Position update
    });
  }


  // Hides the InfoWindow when clicked
  void _hideCustomInfoWindow() {
    setState(() {
      _isInfoWindowVisible = false;
    });
  }

  // Initializes the markers dynamically from imported data
  void _initializeMarkers() async {
    final BitmapDescriptor myCustomMarker = await _createCustomMarker(GlobalImages.customGoogleMarker);

    _markers = data.map((data) => Marker(
      markerId: MarkerId(data["id"]),
      position: data["position"],
      onTap: () => _showCustomInfoWindow(
        data["position"],
        data["title"],
        data["description"],
        data["image"],
      ),
      icon: myCustomMarker // Applies custom marker icon
    )).toSet(); 

    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Google Map widget displaying markers
        GoogleMap(
          onMapCreated: (controller) => mapController = controller,
          initialCameraPosition: CameraPosition(target: _center, zoom: 12.0),
          markers: _markers,
          mapType: MapType.normal,
        ),
        // Custom InfoWindow displayed dynamically near the clicked marker
        if (_isInfoWindowVisible) Positioned(
          top: _infoWindowOffset.dy - 250, // Adjust vertical position
          left: _infoWindowOffset.dx - 0, // Align horizontally
          child: GestureDetector(
            onTap: _hideCustomInfoWindow,
            child: Container(
              width: 200,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              child: Column(
                children: [
                  // Displays all content inside the InfoWindow
                  Image.asset(_infoWindowImage, width: 180, height: 100, fit: BoxFit.cover),
                  SizedBox(height: 10.0),
                  Text(_infoWindowTitle, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.0),
                  Text(_infoWindowDescription, textAlign: TextAlign.justify,),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [TextButton(onPressed: _hideCustomInfoWindow, child: Text("Fermer")),],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//// with infoWindow + Popover 
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../utils/global_others.dart';

// class MyGoogleMap extends StatefulWidget {
//   const MyGoogleMap({super.key});

//   @override
//   MyGoogleMapState createState() => MyGoogleMapState();
// }

// class MyGoogleMapState extends State<MyGoogleMap> {
//   late GoogleMapController mapController;
//   final String googleMapsApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
//   final LatLng _center = const LatLng(48.8566, 2.3522); // Paris
//   Set<Marker> _markers = {}; // Déclaration vide pour être remplie après

//   @override
//   void initState() {
//     super.initState();
//     _initializeMarkers(); // Initialisation des marqueurs après contexte disponible
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   void _onMarkerTap(BuildContext context, String title, String description, String imagePath) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Image.asset(imagePath),
//               Text(description),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Fermer'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _initializeMarkers() {
//     _markers = {
//       Marker(
//         markerId: const MarkerId('chantier1'),
//         position: LatLng(48.8584, 2.2945), // Tour Eiffel
//         infoWindow: InfoWindow(
//           title: 'Chantier Tour Eiffel',
//           snippet: 'Rénovation des structures métalliques',
//           onTap: () {
//             _onMarkerTap(
//               context,
//               'Chantier Tour Eiffel',
//               'Rénovation des structures métalliques',
//               GlobalImages.backgroundLanding,
//             );
//           },
//         ),
//         icon: BitmapDescriptor.defaultMarker,
//       ),
//       Marker(
//         markerId: const MarkerId('chantier2'),
//         position: LatLng(48.8738, 2.295), // Arc de Triomphe
//         infoWindow: InfoWindow(
//           title: 'Chantier Arc de Triomphe',
//           snippet: 'Travaux de façade',
//           onTap: () {
//             _onMarkerTap(
//               context,
//               'Chantier Arc de Triomphe',
//               'Travaux de façade',
//               GlobalImages.backgroundLanding, 
//             );
//           },
//         ),
//         icon: BitmapDescriptor.defaultMarker,
//       ),
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       onMapCreated: _onMapCreated,
//       initialCameraPosition: CameraPosition(
//         target: _center,
//         zoom: 12.0,
//       ),
//       markers: _markers,
//       mapType: MapType.normal,
//       key: Key(googleMapsApiKey),
//     );
//   }
// }
