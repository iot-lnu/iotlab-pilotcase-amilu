// map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:project_tracker/Components/map_screen/unit_list.dart';
import 'package:project_tracker/unit_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _initialPosition = LatLng(37.7749, -122.4194);
  final MapController _mapController = MapController();
  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _addMarker(Marker marker) {
    setState(() {
      _markers.add(marker);
    });
    print("markers length: ${_markers.length}");
    print("Marker added");
  }

  void _emptyMarkers() {
    if (!mounted) return;
    setState(() {
      _markers.clear();
    });
    print("Markers cleared");
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      return;
    }
    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permissions are denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied.");
      return;
    }

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      _mapController.move(_initialPosition, 15);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _initialPosition,
                initialZoom: 11.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(markers:
                  _markers
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: Navigator(
                onGenerateRoute: (settings) {
                  switch (settings.name) {
                    case '/unit':
                      return MaterialPageRoute(
                        builder: (context) => const UnitScreen(),
                      );
                    default:
                      return MaterialPageRoute(
                        builder: (context) => UnitList(addMarker: _addMarker, emptyMarkers: _emptyMarkers),
                      );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
