import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:slow_frp/app/modules/home/controllers/home_controller.dart';
import 'package:slow_frp/app/util/StringUtils.dart';

class StcpController extends GetxController {

  final HomeController homeControllerController = Get.find<HomeController>();

  List<PlutoColumn> columns = [
    PlutoColumn(
      title: '代理标识',
      field: 'proxies',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: '访问密码',
      field: 'sk',
      type: PlutoColumnType.text(),
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
  ];

  List<PlutoRow> rows = [];

  late PlutoGridStateManager stateManager;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadTableData();
  }

  Future<void> loadTableData() async {
    List<PlutoRow> rowList = [];
    Map<String, Map<String, String>> configMap = await homeControllerController.loadConfig2Map();
    configMap.forEach((tag, configModule) {
      if(tag != 'common' && configModule['type'] == 'stcp' && StringUtils.isEmpty(configModule['role'])){
        Map<String, PlutoCell> cells =  {
          'proxies': PlutoCell(value: ''),
          'sk': PlutoCell(value: ''),
          'local_ip': PlutoCell(value: ''),
          'local_port': PlutoCell(value: ''),
        };
        cells['proxies'] = PlutoCell(value: tag);
        configModule.forEach((key, value) {
          cells[key] = PlutoCell(value: value);
        });
        rowList.add(PlutoRow(cells: cells));
      }
    });
    rows = rowList;
  }

  Future<void> saveConfig(List<PlutoRow> rows) async {
    Map<String, Map<String, String>> configMap = {};
    for (var row in rows) {
      Map<String, String> configModule = {};
      String tag = "";
      configModule['type'] = 'stcp';
      if(configModule['server_name'] != null && configModule['server_name']!.isNotEmpty){
        configModule['role'] = 'visitor';
      }
      row.cells.forEach((key, plutoCell) {
        String value = plutoCell.value;
        if(key == "proxies"){
          tag = value;
        }else{
          if(value.isNotEmpty){
            configModule[key] = value;
          }
        }
      });
      configMap[tag] = configModule;
    }
    Map<String, Map<String, String>> oldConfigMap = await homeControllerController.loadConfig2Map();
    oldConfigMap.removeWhere((key, map) => map['type']=='stcp' && StringUtils.isEmpty(map['role']));
    oldConfigMap.addAll(configMap);
    homeControllerController.saveConfig(oldConfigMap);
  }

}