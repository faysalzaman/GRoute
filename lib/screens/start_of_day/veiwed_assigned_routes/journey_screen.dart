// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:g_route/cubit/delivery_assignment/delivery_assignment_cubit.dart';
import 'package:g_route/screens/start_of_day/veiwed_assigned_routes/assign_route_screen.dart';
import 'package:g_route/screens/start_of_day/veiwed_assigned_routes/full_screen_map.dart';
import 'package:g_route/utils/app_loading.dart';
import 'package:g_route/utils/app_navigator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:location/location.dart' as loc;
import 'package:nb_utils/nb_utils.dart';

class JourneyScreen extends StatefulWidget {
  const JourneyScreen({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  GoogleMapController? mapController;
  LatLng? _currentLocation;
  LatLng? _destinationLocation;
  bool _isLoading = true;
  bool _isJourneyLoading = false;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  double distanceInKm = 0.0;

  String? currentAddress;
  String? destinationAddress;

  String? _eta;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  void _initializeLocation() async {
    loc.Location location = loc.Location(); // Use the alias 'loc' for Location
    loc.LocationData locationData = await location.getLocation();

    if (!mounted) return; // Exit if the widget is no longer in the tree

    setState(() {
      _currentLocation =
          LatLng(locationData.latitude!, locationData.longitude!);
      _destinationLocation = LatLng(
        double.parse(DeliveryAssignmentCubit.get(context)
            .deliveryAssignmentModel!
            .orders![widget.index]
            .customerProfile!
            .latitude
            .toString()),
        double.parse(DeliveryAssignmentCubit.get(context)
            .deliveryAssignmentModel!
            .orders![widget.index]
            .customerProfile!
            .longitude
            .toString()),
      );

      // Calculate the distance
      _calculateDistance();

      // Convert current location to address
      _getAddressFromLatLng(_currentLocation!).then((address) {
        if (mounted) {
          setState(() {
            currentAddress = address;
          });
        }
      });

      // Convert destination location to address
      _getAddressFromLatLng(_destinationLocation!).then((address) {
        if (mounted) {
          setState(() {
            destinationAddress = address;
          });
        }
      });

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

  Future<String> _getAddressFromLatLng(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];

    return '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }

  void _calculateDistance() {
    if (!mounted) return; // Exit if the widget is no longer in the tree

    setState(() {
      distanceInKm = Geolocator.distanceBetween(
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

    if (!mounted) return; // Exit if the widget is no longer in the tree

    if (response.statusCode == 200 && jsonData['routes'].isNotEmpty) {
      setState(() {
        _polylines.clear();
        List<LatLng> routePoints = [];

        // Fetch the points along the route
        for (var step in jsonData['routes'][0]['legs'][0]['steps']) {
          var points = step['polyline']['points'];
          routePoints.addAll(_convertToLatLng(_decodePolyline(points)));
        }

        // Extract the duration (in seconds) from the API response
        int durationInSeconds =
            jsonData['routes'][0]['legs'][0]['duration']['value'];

        // Calculate the estimated time of arrival
        DateTime now = DateTime.now();
        DateTime eta = now.add(Duration(seconds: durationInSeconds));

        // Format the ETA
        String formattedEta = DateFormat('hh:mm a').format(eta);

        _polylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            points: routePoints,
            color: Colors.blue,
            width: 5,
          ),
        );

        // Save the ETA in the state
        _eta = formattedEta;
      });
    } else {
      // Handle the case where no routes are found or there's an error
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

  void _startJourney() async {
    setState(() {
      _isJourneyLoading = true;
    });

    // Draw the route
    await _drawRoute();

    if (!mounted) return; // Exit if the widget is no longer in the tree

    // Listen to location updates
    loc.Location location = loc.Location();
    location.onLocationChanged.listen((loc.LocationData currentLocation) {
      if (mounted) {
        setState(() {
          _currentLocation =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });

        // Redraw the route with the new location
        _drawRoute();
      }
    });

    setState(() {
      _isJourneyLoading = false;
    });

    if (mounted) {
      AppNavigator.goToPage(
        context: context,
        screen: FullScreenMap(
          currentLocation: _currentLocation!,
          destinationLocation: _destinationLocation!,
          markers: _markers,
          polylines: _polylines,
        ),
      );
    }
  }

  void _arrive() {
    if (mounted) {
      AppNavigator.replaceTo(
        context: context,
        screen: AssignRouteScreen(
          buttonText: 'Arrived',
          index: widget.index,
        ),
      );
    }
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Driver Location',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      5.height,
                      Text(
                        currentAddress ?? 'Fetching address...',
                      ),
                      const Divider(),
                      const Text(
                        'Customer Location',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      5.height,
                      Text(
                        destinationAddress ?? 'Fetching address...',
                      ),
                      10.height,
                      Row(
                        children: [
                          const Icon(Icons.delivery_dining_outlined),
                          8.width,
                          const Text('Delivery   #1'),
                        ],
                      ),
                      5.height,
                      Row(
                        children: [
                          const Icon(Icons.check_circle_outline),
                          8.width,
                          Text('${distanceInKm.toStringAsFixed(2)} Km'),
                        ],
                      ),
                      5.height,
                      Row(
                        children: [
                          const Icon(Icons.access_time),
                          8.width,
                          Text(_eta ?? 'Calculating...'),
                        ],
                      ),
                      16.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: _startJourney,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: _isJourneyLoading
                                  ? AppLoading.spinkitLoading(Colors.white, 30)
                                  : Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.navigation,
                                            color: Colors.white,
                                          ),
                                          5.width,
                                          const Text(
                                            "Navigate",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _arrive,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                    5.width,
                                    const Text(
                                      "Arrived",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
