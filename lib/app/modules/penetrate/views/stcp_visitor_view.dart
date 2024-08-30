import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/stcp_visitor_controller.dart';

class StcpVisitorView extends StatelessWidget {

  StcpVisitorView({super.key});

  final StcpVisitorController stcpVisitorController = Get.find<StcpVisitorController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () {
                final int lastIndex = stcpVisitorController.stateManager.refRows.originalList.length;
                stcpVisitorController.stateManager.insertRows(lastIndex, [
                  PlutoRow(
                    cells: {
                      'proxies': PlutoCell(value: ''),
                      'server_name': PlutoCell(value: ''),
                      'sk': PlutoCell(value: ''),
                      'bind_addr': PlutoCell(value: ''),
                      'bind_port': PlutoCell(value: ''),
                    },
                  ),
                ]);
              },
              child: const Text('新增行'),
            ),
            OutlinedButton(
              onPressed: () {
                stcpVisitorController.stateManager.removeCurrentRow();
              },
              child: const Text('删除选中行'),
            ),
            OutlinedButton(
              onPressed: () {
                stcpVisitorController.saveConfig(stcpVisitorController.stateManager.rows);
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
              columns: stcpVisitorController.columns,
              rows: stcpVisitorController.rows,
              onLoaded: (event) => stcpVisitorController.stateManager = event.stateManager,
            ),
          ),
        ),
      ],
    );
  }

}