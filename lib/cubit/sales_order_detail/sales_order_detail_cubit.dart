import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_route/controller/sales_order_detail/sales_order_detail_controller.dart';
import 'package:g_route/cubit/sales_order_detail/sales_order_detail_state.dart';
import 'package:g_route/services/connectivity_services.dart';

class SalesOrderDetailCubit extends Cubit<SalesOrderDetailState> {
  SalesOrderDetailCubit() : super(SalesOrderDetailInitial());

  void getSalesOrderDetail(String soRefCodeNo) async {
    emit(SalesOrderDetailLoading());
    try {
      var isConnected = await ConnectivityService.isConnected();
      if (!isConnected) {
        emit(SalesOrderDetailError(message: "No Internet Connection"));
      }

      final salesOrderDetail =
          await SalesOrderDetailController.getSalesOrderDetail(soRefCodeNo);
      emit(SalesOrderDetailLoaded(salesOrderDetail: salesOrderDetail));
    } catch (e) {
      emit(SalesOrderDetailError(
          message: e.toString().replaceAll("Exception:", "")));
    }
  }
}
