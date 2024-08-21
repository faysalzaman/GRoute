import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_route/screens/start_of_day/veiwed_assigned_routes/assign_route_screen.dart';
import 'package:g_route/utils/app_loading.dart';
import 'package:g_route/utils/app_navigator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/cubit/delivery_assignment/delivery_assignment_cubit.dart';
import 'package:g_route/cubit/delivery_assignment/delivery_assignment_state.dart';
import 'package:g_route/widgets/bottom_line_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ViewedAssignedRoutesScreen extends StatefulWidget {
  const ViewedAssignedRoutesScreen({super.key});

  @override
  State<ViewedAssignedRoutesScreen> createState() =>
      _ViewedAssignedRoutesScreenState();
}

class _ViewedAssignedRoutesScreenState
    extends State<ViewedAssignedRoutesScreen> {
  GoogleMapController? mapController;
  final Set<Polygon> _polygons = {};
  final Set<Circle> _circles = {};

  @override
  void initState() {
    super.initState();
    DeliveryAssignmentCubit.get(context).getDeliveryAssignments();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Sales Order's List"),
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
      body: BlocConsumer<DeliveryAssignmentCubit, DeliveryAssignmentState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (!mounted) {
            return const SizedBox(); // Prevents build if not mounted
          }

          if (state is DeliveryAssignmentLoaded) {
            var deliveryAssignments = state.deliveryAssignments;
            String routeArea =
                deliveryAssignments.route!.routeArea!.regionPolygon.toString();

            List<LatLng> coordinates = List<LatLng>.from(
              jsonDecode(routeArea).map(
                (list) => LatLng(list[0].toDouble(), list[1].toDouble()),
              ),
            );

            // Create a polygon from the coordinates
            _polygons.add(
              Polygon(
                polygonId: const PolygonId('route_polygon'),
                points: coordinates,
                strokeColor: Colors.blue,
                strokeWidth: 2,
                fillColor: Colors.blue.withOpacity(0.2),
              ),
            );

            // Create circles around each coordinate
            _circles.clear(); // Clear any existing circles
            for (var coord in coordinates) {
              _circles.add(Circle(
                circleId:
                    CircleId('circle_${coord.latitude}_${coord.longitude}'),
                center: coord,
                onTap: () {},
                radius: 50, // radius in meters
                strokeColor: Colors.red,
                strokeWidth: 2,
                fillColor: Colors.red.withOpacity(0.2),
              ));
            }

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: context.height() * 0.35,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                            ),
                            child: ListView.separated(
                              itemCount:
                                  state.deliveryAssignments.orders!.length,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) => 10.height,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    print(state
                                        .deliveryAssignments.orders![index]);
                                    AppNavigator.goToPage(
                                      context: context,
                                      screen: AssignRouteScreen(
                                        index: index,
                                        buttonText: 'Start Journey',
                                      ),
                                    );
                                  },
                                  child: Material(
                                    elevation: 5,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      width: context.width() * 0.8,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(child: Text("${index + 1}")),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              state
                                                  .deliveryAssignments
                                                  .orders![index]
                                                  .customerProfile!
                                                  .customerName
                                                  .toString(),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              state.deliveryAssignments
                                                          .orders![index].status
                                                          .toString() ==
                                                      "pending"
                                                  ? "Pending"
                                                  : state
                                                              .deliveryAssignments
                                                              .orders![index]
                                                              .status
                                                              .toString() ==
                                                          "out for delivery"
                                                      ? "Out for delivery"
                                                      : "Delivered",
                                              style: TextStyle(
                                                color: state
                                                            .deliveryAssignments
                                                            .orders![index]
                                                            .status ==
                                                        'delivered'
                                                    ? Colors.green
                                                    : state
                                                                .deliveryAssignments
                                                                .orders![index]
                                                                .status ==
                                                            'out for delivery'
                                                        ? Colors.orange
                                                        : Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'View Line Item',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: context.height() * 0.35,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                            ),
                            child: GoogleMap(
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: coordinates.isNotEmpty
                                    ? coordinates[0]
                                    : const LatLng(0, 0),
                                zoom: 14,
                              ),
                              polygons: _polygons,
                              circles: _circles,
                              compassEnabled: true,
                              trafficEnabled: false,
                              buildingsEnabled: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const BottomLineWidget(),
              ],
            );
          }
          if (state is DeliveryAssignmentLoading) {
            return Center(
                child: AppLoading.spinkitLoading(AppColors.primaryColor, 50));
          }
          if (state is DeliveryAssignmentError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  state.message,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
