import 'package:g_route/model/start_of_the_day/customers_profile_model.dart';

abstract class CustomersProfileState {}

class CustomersProfileInitial extends CustomersProfileState {}

class CustomersProfileLoading extends CustomersProfileState {}

class CustomersProfileLoaded extends CustomersProfileState {
  final CustomersProfileModel customersProfileModel;

  CustomersProfileLoaded({required this.customersProfileModel});
}

class CustomersProfileError extends CustomersProfileState {
  final String message;

  CustomersProfileError({required this.message});
}
