// ignore_for_file: unused_field

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_route/cubit/customer_profile/customer_profile_cubit.dart';
import 'package:g_route/cubit/customer_profile/customer_profile_state.dart';
import 'package:g_route/model/start_of_the_day/goods_issue_model.dart';
import 'package:g_route/screens/start_of_day/veiwed_assigned_routes/unload_items_screen.dart';
import 'package:g_route/screens/start_of_day/veiwed_assigned_routes/journey_screen.dart';
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
    required this.updateId,
    required this.gcpGlnId,
    required this.goodsIssueModel,
  });

  final String buttonText;
  final int index;
  final String updateId;
  final String gcpGlnId;
  final GoodsIssueModel goodsIssueModel;

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
    CustomersProfileCubit.get(context).getCustomersProfile(widget.gcpGlnId);
  }

  void _initializeLocation() async {
    Location location = Location();
    LocationData locationData = await location.getLocation();

    if (!mounted) return; // Exit if the widget is no longer in the tree

    setState(() {
      _currentLocation =
          LatLng(locationData.latitude!, locationData.longitude!);
      _destinationLocation = LatLng(
        double.parse(CustomersProfileCubit.get(context)
            .customersProfileModel!
            .latitude
            .toString()),
        double.parse(CustomersProfileCubit.get(context)
            .customersProfileModel!
            .longitude
            .toString()),
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
          : BlocConsumer<CustomersProfileCubit, CustomersProfileState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is CustomersProfileLoading) {
                  Center(
                    child:
                        AppLoading.spinkitLoading(AppColors.primaryColor, 50),
                  );
                }
                if (state is CustomersProfileError) {
                  Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red,
                      ),
                    ),
                  );
                }
                return Padding(
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
                                label: "Customer's Name:",
                                value: CustomersProfileCubit.get(context)
                                        .customersProfileModel!
                                        .customerName ??
                                    "",
                              ),
                              10.height,
                              InfoRow(
                                  label: 'Contact Person:',
                                  value: CustomersProfileCubit.get(context)
                                          .customersProfileModel!
                                          .contactPerson ??
                                      ""),
                              const SizedBox(height: 10),
                              InfoRow(
                                label: 'Date Assigned:',
                                value: DateFormat('dd/MM/yyyy').format(
                                  DateTime.parse(
                                    CustomersProfileCubit.get(context)
                                            .customersProfileModel!
                                            .dateTimeCreated ??
                                        "",
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              InfoRow(
                                label: 'Mobile Number:',
                                value: CustomersProfileCubit.get(context)
                                        .customersProfileModel!
                                        .mobileNumber ??
                                    "",
                              ),
                              const SizedBox(height: 10),
                              InfoRow(
                                label: 'Company Name:',
                                value: CustomersProfileCubit.get(context)
                                        .customersProfileModel!
                                        .companyName ??
                                    "",
                              ),
                              const SizedBox(height: 10),
                              InfoRow(
                                label: 'Adress:',
                                value: CustomersProfileCubit.get(context)
                                        .customersProfileModel!
                                        .address ??
                                    "",
                              ),
                            ],
                          ),
                        ),
                        10.height,
                        GestureDetector(
                          onTap: () async {
                            AppNavigator.replaceTo(
                              context: context,
                              screen: widget.buttonText == "Arrived"
                                  ? UnloadItemsScreen(
                                      index: widget.index,
                                      updateId: widget.updateId,
                                      customersProfileModel:
                                          CustomersProfileCubit.get(context)
                                              .customersProfileModel!,
                                      goodsIssueModel: widget.goodsIssueModel,
                                    )
                                  : JourneyScreen(
                                      index: widget.index,
                                      updateId: widget.updateId,
                                      customersProfileModel:
                                          CustomersProfileCubit.get(context)
                                              .customersProfileModel!,
                                      gcpGlnId: widget.gcpGlnId,
                                      goodsIssueModel: widget.goodsIssueModel,
                                    ),
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
                );
              },
            ),
    );
  }
}
