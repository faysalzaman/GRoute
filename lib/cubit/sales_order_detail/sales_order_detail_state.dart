import 'package:g_route/model/start_of_the_day/sales_order_detail_model.dart';

abstract class SalesOrderDetailState {}

class SalesOrderDetailInitial extends SalesOrderDetailState {}

class SalesOrderDetailLoading extends SalesOrderDetailState {}

class SalesOrderDetailLoaded extends SalesOrderDetailState {
  final List<SalesOrderDetailModel> salesOrderDetail;

  SalesOrderDetailLoaded({required this.salesOrderDetail});
}

class SalesOrderDetailError extends SalesOrderDetailState {
  final String message;

  SalesOrderDetailError({required this.message});
}
