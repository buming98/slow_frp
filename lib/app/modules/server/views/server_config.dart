import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slow_frp/app/models/select_model.dart';
import 'package:slow_frp/app/modules/server/controllers/server_config_controller.dart';

class ServerConfigView extends StatelessWidget {

  ServerConfigView({super.key});

  final ServerConfigController serverConfigController = Get.find<ServerConfigController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: serverConfigController.serverAddRController,
            decoration: const InputDecoration(
                labelText: "服务器地址",
                hintText: '请输入IP或域名'
            ),
          ),
          TextFormField(
            controller: serverConfigController.serverPorTController,
            decoration: const InputDecoration(
                labelText: "服务器端口",
                hintText: '请输入端口'
            ),
          ),
          TextFormField(
            controller: serverConfigController.tokenController,
            decoration: const InputDecoration(
                labelText: "token",
                hintText: '请输入服务器token'
            ),
          ),
          DropdownButtonFormField<dynamic>(
            isExpanded: true,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '启用tls'
            ),
            value: serverConfigController.tlsEnable,
            // 选择回调
            onChanged: (dynamic newPosition) {
              serverConfigController.tlsEnable = newPosition;
            },
            // 传入可选的数组
            items: serverConfigController.tlsEnableSelect.map((SelectModel selectModel) {
              return DropdownMenuItem(value: selectModel.value, child: Text(selectModel.label));
            }).toList(),
          ),
          ElevatedButton(
            child: const Text('保存'),
            onPressed: () {
              serverConfigController.saveServerConfig();
              Get.snackbar("通知", "保存成功", maxWidth: 250, duration: const Duration(seconds: 1));
            },
          )
        ],
      ),
    );
  }
}
