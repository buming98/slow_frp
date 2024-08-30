import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:slow_frp/app/modules/home/controllers/home_controller.dart';

class PenetrateConfigController extends GetxController {

  final HomeController homeControllerController = Get.find<HomeController>();

  List<PlutoColumn> columns = [
    PlutoColumn(
      title: '代理标识',
      field: 'proxies',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: '代理类型',
      field: 'type',
      type: PlutoColumnType.select(['tcp', 'stcp']),
    ),
    PlutoColumn(
      title: '本地IP',
      field: 'local_ip',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: '本地端口',
      field: 'local_port',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: '远程端口',
      field: 'remote_port',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: '访问密码',
      field: 'sk',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: '被控端标识',
      field: 'server_name',
      type: PlutoColumnType.text(),
    ),
  ];

  List<PlutoRow> rows = [];

  late PlutoGridStateManager stateManager;

  @override
  Future<void> onInit() async {
    super.onInit();
    rows = await loadTableData();
  }

  Future<List<PlutoRow>> loadTableData() async {
    List<PlutoRow> rowList = [];
    Map<String, Map<String, String>> configMap = await homeControllerController.loadConfig2Map();
    configMap.forEach((tag, configModule) {
      if(tag != 'common'){
        Map<String, PlutoCell> cells =  {
          'proxies': PlutoCell(value: ''),
          'type': PlutoCell(value: ''),
          'local_ip': PlutoCell(value: ''),
          'local_port': PlutoCell(value: ''),
          'remote_port': PlutoCell(value: ''),
          'sk': PlutoCell(value: ''),
          'server_name': PlutoCell(value: ''),
        };
        cells['proxies'] = PlutoCell(value: tag);
        configModule.forEach((key, value) {
          if(key == 'bind_addr'){
            key = 'local_ip';
          }
          if(key == 'bind_port'){
            key = 'local_port';
          }
          cells[key] = PlutoCell(value: value);
        });
        rowList.add(PlutoRow(cells: cells));
      }
    });
    debugPrint("configMap${configMap.keys}");
    return rowList;
  }

  Future<void> saveConfig(List<PlutoRow> rows) async {
    Map<String, Map<String, String>> configMap = {};
    for (var row in rows) {
      Map<String, String> configModule = {};
      String tag = "";
      bool isVisitor = row.cells['server_name']!.value.isNotEmpty;
      if(isVisitor){
        configModule['role'] = 'visitor';
      }
      row.cells.forEach((key, plutoCell) {
        String value = plutoCell.value;
        if(key == "proxies"){
          tag = value;
        }else{
          if(value.isNotEmpty){
            if(key == 'local_ip' && isVisitor){
              key = 'bind_addr';
            }
            if(key == 'local_port' && isVisitor){
              key = 'bind_port';
            }
            configModule[key] = value;
          }
        }
      });
      configMap[tag] = configModule;
    }
    Map<String, Map<String, String>> oldConfigMap = await homeControllerController.loadConfig2Map();
    Map<String, Map<String, String>> newConfigMap = {};
    newConfigMap["common"] = oldConfigMap["common"]!;
    newConfigMap.addAll(configMap);
    homeControllerController.saveConfig(newConfigMap);
  }

}
