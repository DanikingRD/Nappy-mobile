import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:nappy_mobile/common/util/notification.dart';
import 'package:nappy_mobile/common/widgets/toast.dart';

Future<bool> handleConnectionError(BuildContext context) async {
  final result = await checkConnection(
    noneConnectionHandler: () {
      showToast(
        message: "No internet connection",
        type: NotificationType.error,
        context: context,
      );
    },
  );
  return result;
}

Future<bool> checkConnection({
  required Function() noneConnectionHandler,
  Function()? mobileConnectionHandler,
  Function()? wifiConnectionHandler,
}) async {
  final instance = Connectivity();
  final res = await instance.checkConnectivity();
  switch (res) {
    case ConnectivityResult.none:
      noneConnectionHandler();
      return false;
    case ConnectivityResult.mobile:
      mobileConnectionHandler?.call();
      return true;
    case ConnectivityResult.wifi:
      wifiConnectionHandler?.call();
      return true;
  }
}
