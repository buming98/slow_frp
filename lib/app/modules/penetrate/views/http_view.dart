import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/http_controller.dart';

class HttpView extends StatelessWidget {

  HttpView({super.key});

  final HttpController httpController = Get.find<HttpController>();

  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(httpController.loadingCompleted.isFalse){
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('http配置加载中...'),
              SizedBox(height: 16),
              CircularProgressIndicator(),
            ],
          ),
        );
      }
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {
                  final int lastIndex = httpController.stateManager.refRows.originalList.length;
                  httpController.stateManager.insertRows(lastIndex, [
                    PlutoRow(
                      cells: {
                        'proxies': PlutoCell(value: ''),
                        'local_ip': PlutoCell(value: ''),
                        'local_port': PlutoCell(value: ''),
                        'custom_domains': PlutoCell(value: ''),
                        'remote_port': PlutoCell(value: ''),
                      },
                    ),
                  ]);
                },
                child: const Text('新增行'),
              ),
              OutlinedButton(
                onPressed: () {
                  httpController.stateManager.removeCurrentRow();
                },
                child: const Text('删除选中行'),
              ),
              OutlinedButton(
                onPressed: () {
                  httpController.saveConfig(httpController.stateManager.rows);
                  Get.snackbar("通知", "保存成功", maxWidth: 250, duration: const Duration(seconds: 1));
                },
                child: const Text('保存'),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              child: PlutoGrid(
                columns: httpController.columns,
                rows: httpController.rows,
                onLoaded: (event) => httpController.stateManager = event.stateManager,
              ),
            ),
          ),
        ],
      );
    });
  }

}