import 'package:g_route/screens/start_of_day/veiwed_assigned_routes/unload_items_screen.dart';
import 'package:g_route/screens/start_of_day/veiwed_assigned_routes/journey_screen.dart';
import 'package:g_route/cubit/delivery_assignment/delivery_assignment_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:g_route/widgets/info_row_widget.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/utils/app_navigator.dart';
import 'package:g_route/utils/app_loading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssignRouteScreen extends StatefulWidget {
  const AssignRouteScreen({
    super.key,
    required this.buttonText,
    required this.index,
  });

  final String buttonText;
  final int index;

  @override
  State<AssignRouteScreen> createState() => _AssignRouteScreenState();
}

class _AssignRouteScreenState extends State<AssignRouteScreen> {
  GoogleMapController? mapController;
  LatLng? _currentLocation;
  LatLng? _destinationLocation;
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
        double.parse(
          DeliveryAssignmentCubit.get(context)
              .deliveryAssignmentModel!
              .orders![widget.index]
              .customerProfile!
              .longitude
              .toString(),
        ),
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
    if (!mounted) return; // Exit if the widget is no longer in the tree

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
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: context.height() * 0.45,
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
                    10.height,
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
                            value: DeliveryAssignmentCubit.get(context)
                                .deliveryAssignmentModel!
                                .orders![widget.index]
                                .pickingRouteId
                                .toString(),
                          ),
                          10.height,
                          InfoRow(
                              label: 'Inventory Location ID:',
                              value: DeliveryAssignmentCubit.get(context)
                                  .deliveryAssignmentModel!
                                  .orders![widget.index]
                                  .inventLocationId
                                  .toString()),
                          const SizedBox(height: 10),
                          InfoRow(
                            label: 'Date Assigned:',
                            value: DateFormat('dd/MM/yyyy').format(
                              DateTime.parse(
                                  DeliveryAssignmentCubit.get(context)
                                      .deliveryAssignmentModel!
                                      .orders![widget.index]
                                      .createdAt
                                      .toString()),
                            ),
                          ),
                          const SizedBox(height: 10),
                          InfoRow(
                            label: 'WMS Location:',
                            value: DeliveryAssignmentCubit.get(context)
                                .deliveryAssignmentModel!
                                .orders![widget.index]
                                .wmsLocationId
                                .toString(),
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
                    10.height,
                    GestureDetector(
                      onTap: () {
                        AppNavigator.replaceTo(
                          context: context,
                          screen: widget.buttonText == "Arrived"
                              ? UnloadItemsScreen(index: widget.index)
                              : JourneyScreen(index: widget.index),
                        );
                      },
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
                            widget.buttonText,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
