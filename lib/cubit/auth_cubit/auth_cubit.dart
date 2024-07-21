import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_route/constants/app_preferences.dart';
import 'package:g_route/controller/auth_controller/auth_controller.dart';
import 'package:g_route/cubit/auth_cubit/auth_state.dart';
import 'package:g_route/services/connectivity_services.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login(String email, String password) async {
    emit(AuthLoading());
    try {
      var isConnected = await ConnectivityService.isConnected();
      if (!isConnected) {
        emit(AuthFailed("No Internet Connection"));
      }
      final user = await AuthController.login(email, password);
      await AppPreferences.setUserId(user.id.toString());
      await AppPreferences.setMemberId(user.memberId.toString());
      await AppPreferences.setEmail(user.email.toString());
      await AppPreferences.setName(user.name.toString());
      await AppPreferences.setGsrnIdNumber(user.gsrnIdNumber.toString());
      await AppPreferences.setMobileNumber(user.mobileNumber.toString());
      await AppPreferences.setResidenceIdNumber(
          user.residenceIdNumber.toString());
      await AppPreferences.setNationalAddressQrcode(
          user.nationalAddressQrcode.toString());
      await AppPreferences.setRole(user.role.toString());

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString().replaceAll("Exception:", "")));
    }
  }
}
