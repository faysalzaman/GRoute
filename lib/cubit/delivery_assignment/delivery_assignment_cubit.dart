import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_route/controller/delivery_contorller/delivery_controller.dart';
import 'package:g_route/cubit/delivery_assignment/delivery_assignment_state.dart';
import 'package:g_route/services/connectivity_services.dart';

class DeliveryAssignmentCubit extends Cubit<DeliveryAssignmentState> {
  DeliveryAssignmentCubit() : super(DeliveryAssignmentInitial());

  void getDeliveryAssignments() async {
    emit(DeliveryAssignmentLoading());
    try {
      var isConnected = await ConnectivityService.isConnected();
      if (!isConnected) {
        emit(DeliveryAssignmentError(message: "No Internet Connection"));
      }

      final deliveryAssignments =
          await DeliveryController.getdeliveryAssignmentInfo();
      emit(DeliveryAssignmentLoaded(deliveryAssignments: deliveryAssignments));
    } catch (e) {
      emit(DeliveryAssignmentError(
          message: e.toString().replaceAll("Exception:", "")));
    }
  }
}
