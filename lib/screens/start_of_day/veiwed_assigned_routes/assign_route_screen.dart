import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:g_route/screens/start_of_day/veiwed_assigned_routes/unload_items_screen.dart';
import 'package:g_route/utils/app_loading.dart';
import 'package:g_route/utils/app_navigator.dart';
import 'package:g_route/widgets/bottom_line_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/model/deal_of_the_day/orders_model.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AssignRouteScreen extends StatefulWidget {
  const AssignRouteScreen({super.key, required this.ordersModel});

  final OrdersModel ordersModel;

  @override
  State<AssignRouteScreen> createState() => _AssignRouteScreenState();
}

class _AssignRouteScreenState extends State<AssignRouteScreen> {
  GoogleMapController? mapController;
  LatLng? _currentLocation;
  LatLng? _destinationLocation;
  bool _journeyStarted = false;
  bool _isLoading = true;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  double _distanceInKm = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  void _initializeLocation() async {
    Location location = Location();
    LocationData locationData = await location.getLocation();

    setState(() {
      _currentLocation =
          LatLng(locationData.latitude!, locationData.longitude!);
      _destinationLocation = LatLng(
        double.parse(widget.ordersModel.customerProfile!.latitude.toString()),
        double.parse(widget.ordersModel.customerProfile!.longitude.toString()),
      );

      // Calculate the distance
      _calculateDistance();

      // Add marker to the destination
      _markers.add(
        Marker(
          markerId: const MarkerId('destinationLocation'),
          position: _destinationLocation!,
          infoWindow: const InfoWindow(title: 'Destination Location'),
        ),
      );

      _isLoading = false; // Set loading to false once everything is ready
    });
  }

  void _calculateDistance() {
    setState(() {
      _distanceInKm = Geolocator.distanceBetween(
            _currentLocation!.latitude,
            _currentLocation!.longitude,
            _destinationLocation!.latitude,
            _destinationLocation!.longitude,
          ) /
          1000; // Convert to kilometers
    });
  }

  Future<void> _drawRoute() async {
    if (_destinationLocation == null || _currentLocation == null) return;

    final String? googleAPIKey = dotenv.env['FLUTTER_APP_GOOGLE_MAP_API_KEY'];
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_currentLocation!.latitude},${_currentLocation!.longitude}&destination=${_destinationLocation!.latitude},${_destinationLocation!.longitude}&key=$googleAPIKey';

    final response = await http.get(Uri.parse(url));
    final jsonData = json.decode(response.body);

    if (jsonData['routes'].isNotEmpty) {
      setState(() {
        _polylines.clear();
        List<LatLng> routePoints = [];

        // Fetch the points along the route
        for (var step in jsonData['routes'][0]['legs'][0]['steps']) {
          var points = step['polyline']['points'];
          routePoints.addAll(_convertToLatLng(_decodePolyline(points)));
        }

        _polylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            points: routePoints,
            color: Colors.blue,
            width: 5,
          ),
        );
      });
    }
  }

  List<LatLng> _convertToLatLng(List<dynamic> points) {
    List<LatLng> result = [];
    for (var point in points) {
      result.add(LatLng(point['lat'], point['lng']));
    }
    return result;
  }

  List<dynamic> _decodePolyline(String polyline) {
    List<dynamic> points = [];
    int index = 0;
    int len = polyline.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add({'lat': lat / 1E5, 'lng': lng / 1E5});
    }

    return points;
  }

  void _startJourney() {
    setState(() {
      _journeyStarted = true;
    });

    // Draw the route
    _drawRoute();

    // Listen to location updates
    Location location = Location();
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentLocation =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });

      // Redraw the route with the new location
      _drawRoute();
    });
  }

  void _arrive() {
    // Redirect to another screen when the "Arrive" button is pressed
    AppNavigator.replaceTo(context: context, screen: const UnloadItemsScreen());
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Assign Route"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? Center(
              child: AppLoading.spinkitLoading(AppColors.primaryColor, 50),
            ) // Show a loader while initializing
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: context.height() * 0.48,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor),
                          ),
                          child: GoogleMap(
                            onMapCreated: (controller) {
                              mapController = controller;
                            },
                            initialCameraPosition: CameraPosition(
                              target: _currentLocation!,
                              zoom: 14,
                            ),
                            markers: _markers,
                            polylines: _polylines,
                            myLocationEnabled: true,
                            myLocationButtonEnabled: true,
                            trafficEnabled: true,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InfoRow(
                                label: 'Picking Route ID:',
                                value: widget.ordersModel.pickingRouteId
                                    .toString(),
                              ),
                              const SizedBox(height: 10),
                              InfoRow(
                                label: 'Inventory Location ID:',
                                value: widget.ordersModel.inventLocationId
                                    .toString(),
                              ),
                              const SizedBox(height: 10),
                              InfoRow(
                                label: 'Date Assigned:',
                                value: DateFormat('dd/MM/yyyy').format(
                                  DateTime.parse(
                                      widget.ordersModel.createdAt.toString()),
                                ),
                              ),
                              const SizedBox(height: 10),
                              InfoRow(
                                label: 'WMS Location:',
                                value:
                                    widget.ordersModel.wmsLocationId.toString(),
                              ),
                              const SizedBox(height: 10),
                              InfoRow(
                                label: 'Distance:',
                                value: '${_distanceInKm.toStringAsFixed(2)} km',
                              ),
                              const SizedBox(height: 10),
                              const InfoRow(
                                label: 'Duration:',
                                value:
                                    '2 days  6 hours', // You should calculate this dynamically
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: _journeyStarted ? _arrive : _startJourney,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.all(5),
                            height: 50,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                _journeyStarted ? "Arrived" : "Start Journey",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const BottomLineWidget(),
              ],
            ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
