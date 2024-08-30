import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/stcp_controller.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/tcp_controller.dart';

class StcpView extends StatelessWidget {

  StcpView({super.key});

  final StcpController stcpController = Get.find<StcpController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () {
                final int lastIndex = stcpController.stateManager.refRows.originalList.length;
                stcpController.stateManager.insertRows(lastIndex, [
                  PlutoRow(
                    cells: {
                      'proxies': PlutoCell(value: ''),
                      'sk': PlutoCell(value: ''),
                      'local_ip': PlutoCell(value: ''),
                      'local_port': PlutoCell(value: ''),
                    },
                  ),
                ]);
              },
              child: const Text('新增行'),
            ),
            OutlinedButton(
              onPressed: () {
                stcpController.stateManager.removeCurrentRow();
              },
              child: const Text('删除选中行'),
            ),
            OutlinedButton(
              onPressed: () {
                stcpController.saveConfig(stcpController.stateManager.rows);
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
              columns: stcpController.columns,
              rows: stcpController.rows,
              onLoaded: (event) => stcpController.stateManager = event.stateManager,
            ),
          ),
        ),
      ],
    );
  }

}