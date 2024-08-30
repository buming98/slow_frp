import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/tcp_controller.dart';

class TcpView extends StatelessWidget {

  TcpView({super.key});

  final TcpController tcpController = Get.find<TcpController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () {
                final int lastIndex = tcpController.stateManager.refRows.originalList.length;
                tcpController.stateManager.insertRows(lastIndex, [
                  PlutoRow(
                    cells: {
                      'proxies': PlutoCell(value: ''),
                      'local_ip': PlutoCell(value: ''),
                      'local_port': PlutoCell(value: ''),
                      'remote_port': PlutoCell(value: ''),
                    },
                  ),
                ]);
              },
              child: const Text('新增行'),
            ),
            OutlinedButton(
              onPressed: () {
                tcpController.stateManager.removeCurrentRow();
              },
              child: const Text('删除选中行'),
            ),
            OutlinedButton(
              onPressed: () {
                tcpController.saveConfig(tcpController.stateManager.rows);
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
              columns: tcpController.columns,
              rows: tcpController.rows,
              onLoaded: (event) => tcpController.stateManager = event.stateManager,
            ),
          ),
        ),
      ],
    );
  }

}