import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:slow_frp/app/models/select_model.dart';
import 'package:slow_frp/app/modules/home/controllers/home_controller.dart';
import 'package:slow_frp/app/util/PathUtils.dart';

class ServerConfigController extends GetxController {

  final HomeController homeControllerController = Get.find<HomeController>();

  TextEditingController serverAddRController = TextEditingController();
  TextEditingController serverPorTController = TextEditingController();
  TextEditingController tokenController = TextEditingController();
  bool tlsEnable = false;
  final List<SelectModel> tlsEnableSelect = [
    SelectModel(label: "是", value: true),
    SelectModel(label: "否", value: false)
  ];

  @override
  void onInit() {
    super.onInit();
    loadServerConfig();
  }

  Future<void> loadServerConfig() async {
    var frpcConfigFile = File(await PathUtils.getFrpcConfigPath());
    if(frpcConfigFile.existsSync()){
      String tag = ""; // 配置标识
      frpcConfigFile.readAsLinesSync().forEach((line) {
        if(line.isEmpty){
          return;
        }
        line = line.replaceAll(" ", "");
        if(line.contains("[") && line.contains("]")){
          tag = line.replaceAll("[", "").replaceAll("]", "");
          return;
        }
        if(tag == "common"){
          List<String> lineMap = line.split("=");
          String lineKey = lineMap[0];
          String lineValue = lineMap[1];
          if(lineKey == "server_addr"){
            serverAddRController.text = lineValue;
          }else if(lineKey == "server_port"){
            serverPorTController.text = lineValue;
          }else if(lineKey == "token"){
            tokenController.text = lineValue;
          }else if(lineKey == "tls_enable"){
            tlsEnable = lineValue == "true";
          }
        }
      });
    }
  }

  Future<void> saveServerConfig() async {
    StringBuffer newConfig = StringBuffer();
    newConfig.writeln("[common]");
    newConfig.writeln("server_addr=${serverAddRController.text}");
    newConfig.writeln("server_port=${serverPorTController.text}");
    if(tokenController.text.isNotEmpty){
      newConfig.writeln("token=${tokenController.text}");
    }
    newConfig.writeln("tls_enable=$tlsEnable");
    // 写入其他配置
    var frpcConfigFile = File(await PathUtils.getFrpcConfigPath());
    if(frpcConfigFile.existsSync()){
      String tag = ""; // 配置标识
      frpcConfigFile.readAsLinesSync().forEach((line) {
        if(line.isEmpty){
          return;
        }
        line = line.replaceAll(" ", "");
        if(line.contains("[") && line.contains("]")){
          tag = line.replaceAll("[", "").replaceAll("]", "");
          if(tag != "common"){
            newConfig.writeln("[$tag]");
          }
        }else{
          if(tag != "common"){
            newConfig.writeln(line);
          }
        }
      });
    }
    frpcConfigFile.writeAsStringSync(newConfig.toString());
    homeControllerController.frpcConfigController.value.text = newConfig.toString();
  }

}
