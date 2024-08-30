import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:slow_frp/app/constants/frpc_constants.dart';

class PathUtils {

  static Future<String> getFrpcPath() async {
    if(Platform.isMacOS){
      Directory asd = await getApplicationSupportDirectory();
      return "${asd.path}/$frpcPath";
    }
    return frpcPath;
  }

  static Future<String> getFrpcConfigPath() async {
    if(Platform.isMacOS){
      Directory asd = await getApplicationSupportDirectory();
      return "${asd.path}/$frpcConfigPath";
    }
    return frpcConfigPath;
  }

}