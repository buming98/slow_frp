import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_console_widget/flutter_console.dart';
import 'package:get/get.dart';
import 'package:slow_frp/app/modules/frpc/util/frp_log_utils.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/http_controller.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/stcp_controller.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/stcp_visitor_controller.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/tcp_controller.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/udp_controller.dart';
import 'package:slow_frp/app/modules/server/controllers/server_config_controller.dart';
import 'package:slow_frp/app/util/PathUtils.dart';

class FrpcController extends GetxController {

  var isLoading = false.obs;
  Rx<Process?> frpcProcess = Rx<Process?>(null);
  RxBool get isRunning => (frpcProcess.value != null).obs;
  Rx<TextEditingController> frpcConfigController = TextEditingController().obs;
  FlutterConsoleController consoleController = FlutterConsoleController();

  @override
  void onInit() {
    super.onInit();
    loadFrpcConfig();
  }

  void start() async {
    if (frpcProcess.value != null) return;
    isLoading.value = true;
    consoleController.clear();
    var frpcConfigPath = await PathUtils.getFrpcConfigPath();
    var frpcPath = await PathUtils.getFrpcPath();
    var tempProcess = await Process.start(frpcPath, ['-c', frpcConfigPath,]);
    tempProcess.exitCode.then((exitCode) {
      if(exitCode != 0){
        Get.snackbar("通知", "FRP程序退出", maxWidth: 250, duration: const Duration(seconds: 1));
        isLoading.value = false;
      }
    });
    debugPrint("监听日志");
    tempProcess.stdout.transform(utf8.decoder).listen((data) async {
      debugPrint(data);
      consoleController.print(message: FrpLogUtils.removeColorTags(data), endline: true);
      consoleController.focusNode.requestFocus();
      if (data.contains('success')) {
        frpcProcess.value = tempProcess;
        debugPrint('started frpc.exe process, pid: ${tempProcess.pid}');
        isLoading.value = false;
        return;
      }
      if (data.contains('already in use')) {
        debugPrint('port already used');
        // kill current proccess
        tempProcess.kill();
        // show error dialog
        Get.dialog(AlertDialog(
          title: const Text('错误'),
          content: const Text('端口被占用'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('关闭'),
              onPressed: () {
                Get.back();
              },
            ),
            ElevatedButton(
              child: const Text('关闭占用端口的程序'),
              onPressed: () async {
                // kill all processes frpc.exe
                Platform.isWindows
                    ? Process.run('taskkill', ['/f', '/im', 'frpc.exe'])
                    : Process.run('killall', ['frpc']);
                isRunning(false);
                Get.back();
              },
            ),
          ],
        ));
        isLoading.value = false;
      }
    });

  }

  Future<void> stop() async {
    if (frpcProcess.value == null) return;
    frpcProcess.value?.kill();
    frpcProcess.value = null;
    isLoading.value = false;
  }

  Future<void> saveCustomConfig() async {
    await writeConfigFile(frpcConfig: frpcConfigController.value.text);
    Get.find<ServerConfigController>().loadServerConfig();
    Get.find<HttpController>().loadTableData();
    Get.find<TcpController>().loadTableData();
    Get.find<UdpController>().loadTableData();
    Get.find<StcpController>().loadTableData();
    Get.find<StcpVisitorController>().loadTableData();
  }

  Future<void> writeConfigFile({required String frpcConfig}) async {
    var frpcConfigFile = File(await PathUtils.getFrpcConfigPath());
    frpcConfigFile.writeAsStringSync(frpcConfig);
  }

  Future<void> loadFrpcConfig() async {
    var frpcConfigFile = File(await PathUtils.getFrpcConfigPath());
    if(!frpcConfigFile.existsSync()){
      frpcConfigController.value.text = "";
      return;
    }
    frpcConfigController.value.text = frpcConfigFile.readAsStringSync();
  }

  Future<Map<String, Map<String, String>>> loadConfig2Map() async {
    Map<String, Map<String, String>> configMap = {};
    Map<String, String> configModule = {};
    String tag = ""; // 配置标识
    var frpcConfigFile = File(await PathUtils.getFrpcConfigPath());
    if(frpcConfigFile.existsSync()){
      frpcConfigFile.readAsLinesSync().forEach((line) {
        if(line.isEmpty){
          return;
        }
        line = line.replaceAll(" ", "");
        if(line.contains("[") && line.contains("]")){
          String newTag = line.replaceAll("[", "").replaceAll("]", "");
          if(tag != "" && newTag != tag){
            configMap[tag] = configModule;
            configModule = {};
          }
          tag = newTag;
          return;
        }
        List<String> lineMap = line.split("=");
        String lineKey = lineMap[0];
        String lineValue = lineMap[1];
        configModule[lineKey] = lineValue;
      });
    }
    configMap[tag] = configModule;
    return configMap;
  }

  void saveConfig(Map<String, Map<String, String>> configMap) {
    StringBuffer newConfig = StringBuffer();
    configMap.forEach((key, configModule) {
      newConfig.writeln("[$key]");
      configModule.forEach((key, value) {
        newConfig.writeln("$key=$value");
      });
    });
    writeConfigFile(frpcConfig: newConfig.toString());
    frpcConfigController.value.text = newConfig.toString();
  }

}
