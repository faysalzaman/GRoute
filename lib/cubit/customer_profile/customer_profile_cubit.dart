import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_route/controller/sales_order/sales_order_controller.dart';
import 'package:g_route/cubit/customer_profile/customer_profile_state.dart';
import 'package:g_route/model/start_of_the_day/customers_profile_model.dart';
import 'package:g_route/services/connectivity_services.dart';

class CustomersProfileCubit extends Cubit<CustomersProfileState> {
  CustomersProfileCubit() : super(CustomersProfileInitial());

  static CustomersProfileCubit get(context) => BlocProvider.of(context);

  CustomersProfileModel? customersProfileModel;

  void getCustomersProfile(String gcpGlnId) async {
    emit(CustomersProfileLoading());
    try {
      var isConnected = await ConnectivityService.isConnected();
      if (!isConnected) {
        emit(CustomersProfileError(message: "No Internet Connection"));
      }
      customersProfileModel =
          await SalesOrderController.getCustomerProfile(gcpGlnId);
      emit(CustomersProfileLoaded(
          customersProfileModel: customersProfileModel!));
    } catch (e) {
      emit(CustomersProfileError(message: e.toString()));
    }
  }
}
