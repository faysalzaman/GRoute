part of 'sales_order_cubit.dart';

abstract class SalesOrderState {}

class SalesOrderInitial extends SalesOrderState {}

final class SalesOrderAssignedOrdersLoading extends SalesOrderState {}

final class SalesOrderGoodsIssueLoading extends SalesOrderState {}

// SUCCESS
final class SalesOrderAssignedOrdersSuccess extends SalesOrderState {}

final class SalesOrderGoodsIssueSuccess extends SalesOrderState {}

// Filter State

final class SalesOrderAssignedFilterState extends SalesOrderState {}

// ERROR
final class SalesOrderAssignedOrdersError extends SalesOrderState {
  final String message;

  SalesOrderAssignedOrdersError(this.message);
}

final class SalesOrderGoodsIssueError extends SalesOrderState {
  final String message;

  SalesOrderGoodsIssueError(this.message);
}

final class SalesOrderGtinProductLoadingState extends SalesOrderState {}

final class SalesOrderGtinProductSuccessState extends SalesOrderState {
  final GtinProductModel gtinProductModel;

  SalesOrderGtinProductSuccessState(this.gtinProductModel);
}

final class SalesOrderGtinProductErrorState extends SalesOrderState {
  final String message;

  SalesOrderGtinProductErrorState(this.message);
}
