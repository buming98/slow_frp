import 'dart:io';

import 'package:slow_frp/app/modules/home/controllers/frpc_controller.dart';
import 'package:slow_frp/app/util/PathUtils.dart';

class SplashController extends FrpcController {

  Future<bool> checkIfFrpcExists() async {
    var frpcConfigFile = await PathUtils.getFrpcPath();
    final fileExist = File(frpcConfigFile).existsSync();
    return fileExist;
  }

}
