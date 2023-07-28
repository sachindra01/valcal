import 'package:connectivity_plus/connectivity_plus.dart';


bool isOnline = true;

checkInitialConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  checkForConnectivityChange();
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}

checkForConnectivityChange() {
  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      isOnline = true;
    }
    else{
      isOnline = false;
    }
  });
  return isOnline;
}