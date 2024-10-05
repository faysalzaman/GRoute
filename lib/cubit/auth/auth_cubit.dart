import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_route/constants/app_preferences.dart';
import 'package:g_route/controller/auth_controller/auth_controller.dart';
import 'package:g_route/cubit/auth/auth_state.dart';
import 'package:g_route/services/connectivity_services.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login(String email, String password) async {
    emit(AuthLoading());

    try {
      // Check for internet connection
      var isConnected = await ConnectivityService.isConnected();
      if (!isConnected) {
        emit(AuthFailed("No Internet Connection"));
        return; // Stop further execution if there's no internet
      }

      // Attempt to login
      final user = await AuthController.login(email, password);

      // Check if any fields are null before saving
      if (user.id != null) await AppPreferences.setUserId(user.id.toString());
      if (user.memberId != null) {
        await AppPreferences.setMemberId(user.memberId.toString());
      }
      if (user.email != null) {
        await AppPreferences.setEmail(user.email.toString());
      }
      if (user.name != null) await AppPreferences.setName(user.name.toString());
      if (user.gsrnIdNumber != null) {
        await AppPreferences.setGsrnIdNumber(user.gsrnIdNumber.toString());
      }
      if (user.mobileNumber != null) {
        await AppPreferences.setMobileNumber(user.mobileNumber.toString());
      }
      if (user.residenceIdNumber != null) {
        await AppPreferences.setResidenceIdNumber(
            user.residenceIdNumber.toString());
      }
      if (user.nationalAddressQRCode != null) {
        await AppPreferences.setNationalAddressQrcode(
            user.nationalAddressQRCode.toString());
      }
      if (user.role != null) await AppPreferences.setRole(user.role.toString());

      // Emit success state with the user data
      emit(AuthSuccess(user));
    } catch (e) {
      // Emit failure state with the error message
      emit(AuthFailed(e.toString().replaceAll("Exception:", "")));
    }
  }
}
