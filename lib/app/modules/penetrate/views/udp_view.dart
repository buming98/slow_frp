import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/udp_controller.dart';

class UdpView extends StatelessWidget {

  UdpView({super.key});

  final UdpController udpController = Get.find<UdpController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () {
                final int lastIndex = udpController.stateManager.refRows.originalList.length;
                udpController.stateManager.insertRows(lastIndex, [
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
                udpController.stateManager.removeCurrentRow();
              },
              child: const Text('删除选中行'),
            ),
            OutlinedButton(
              onPressed: () {
                udpController.saveConfig(udpController.stateManager.rows);
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
              columns: udpController.columns,
              rows: udpController.rows,
              onLoaded: (event) => udpController.stateManager = event.stateManager,
            ),
          ),
        ),
      ],
    );
  }

}