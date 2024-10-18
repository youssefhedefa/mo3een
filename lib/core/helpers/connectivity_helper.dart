import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  static Connectivity connectivity = Connectivity();

  static Future<bool> isConnected() async {
    var connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet)) {
      return true;
    } else {
      return false;
    }
  }
}
