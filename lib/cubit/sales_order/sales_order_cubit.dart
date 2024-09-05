import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_route/controller/sales_order/sales_order_controller.dart';
import 'package:g_route/model/start_of_the_day/assigned_orders_model.dart';
import 'package:g_route/model/start_of_the_day/goods_issue_model.dart';
import 'package:g_route/model/start_of_the_day/gtin_product_model.dart';
import 'package:g_route/services/connectivity_services.dart';

part 'sales_order_state.dart';

class SalesOrderCubit extends Cubit<SalesOrderState> {
  SalesOrderCubit() : super(SalesOrderInitial());

  static SalesOrderCubit get(context) => BlocProvider.of(context);

  //// Variables
  List<AssignedOrdersModel> assignedOrders = [];
  List<AssignedOrdersModel> filterAssignedOrders = [];
  List<GoodsIssueModel> goodsIssueDetails = [];
  GtinProductModel? gtinProductModel;

  void getAssignedOrders() async {
    emit(SalesOrderAssignedOrdersLoading());
    try {
      var isConnected = await ConnectivityService.isConnected();
      if (!isConnected) {
        emit(SalesOrderAssignedOrdersError("No Internet Connection"));
      }
      assignedOrders = await SalesOrderController.getAssignedOrders();
      emit(SalesOrderAssignedOrdersSuccess());
    } catch (e) {
      emit(SalesOrderAssignedOrdersError(e.toString()));
    }
  }

  void getFilterAssignedOrders(var query) async {
    try {
      filterAssignedOrders = assignedOrders
          .where((element) => element.tblGoodsIssueMaster!.salesOrderNo!
              .toLowerCase()
              .contains(query))
          .toList();
    } catch (e) {
      emit(SalesOrderAssignedOrdersError(e.toString()));
    }
  }

  void getGoodsIssueDetails(String id) async {
    emit(SalesOrderGoodsIssueLoading());
    try {
      goodsIssueDetails = await SalesOrderController.getGoodsIssueDetails(id);
      emit(SalesOrderGoodsIssueSuccess());
    } catch (e) {
      emit(SalesOrderGoodsIssueError(e.toString()));
    }
  }

  void getGtinProduct(String gtin) async {
    emit(SalesOrderGtinProductLoadingState());
    try {
      var isConnected = await ConnectivityService.isConnected();
      if (!isConnected) {
        emit(SalesOrderGtinProductErrorState("No Internet Connection"));
      }
      gtinProductModel = await SalesOrderController.getGtinProductModel(gtin);

      emit(SalesOrderGtinProductSuccessState(gtinProductModel!));
    } catch (e) {
      emit(SalesOrderGtinProductErrorState(e.toString()));
    }
  }
}
