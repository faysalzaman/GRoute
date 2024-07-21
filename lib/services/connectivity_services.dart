// ignore_for_file: no_leading_underscores_for_local_identifiers, unrelated_type_equality_checks

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static Future<bool> isConnected() async {
    final Connectivity _connectivity = Connectivity();
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
