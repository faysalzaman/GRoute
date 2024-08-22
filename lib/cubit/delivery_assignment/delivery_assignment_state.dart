import 'package:g_route/model/start_of_the_day/delivery_assignment_model.dart';

abstract class DeliveryAssignmentState {}

class DeliveryAssignmentInitial extends DeliveryAssignmentState {}

class DeliveryAssignmentLoading extends DeliveryAssignmentState {}

class DeliveryAssignmentLoaded extends DeliveryAssignmentState {
  final DeliveryAssignmentModel deliveryAssignments;

  DeliveryAssignmentLoaded({required this.deliveryAssignments});
}

class DeliveryAssignmentError extends DeliveryAssignmentState {
  final String message;

  DeliveryAssignmentError({required this.message});
}
