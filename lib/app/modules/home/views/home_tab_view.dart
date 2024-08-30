import 'package:flutter/material.dart';
import 'package:flutter_console_widget/flutter_console.dart';
import 'package:get/get.dart';
import 'package:slow_frp/app/modules/home/controllers/home_controller.dart';

class HomeTabView extends StatelessWidget {

  HomeTabView({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                var isLoading = homeController.isLoading.value;
                var isRunning = homeController.isRunning.value;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 100),
                      backgroundColor: isLoading
                          ? Colors.yellow
                          : isRunning
                          ? Colors.red
                          : Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  ),
                  onPressed: isRunning
                      ? () => homeController.stop()
                      : () {
                    homeController.start();
                  },
                  child: isLoading
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(),
                  )
                      : Text(
                    isRunning ? '关闭' : '启动',
                  ),
                );
              },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: '高级设置',
                    content: SizedBox(
                      width: 500,
                      child: Obx(() {
                        return TextField(
                          controller: homeController.frpcConfigController.value,
                          maxLines: 20,
                          minLines: 10,
                        );
                      }),
                    ),
                    textConfirm: '保存',
                    onConfirm: () async {
                      await homeController.saveCustomConfig();
                      Get.back();
                      Get.snackbar("通知", "保存成功", maxWidth: 250, duration: const Duration(seconds: 1));
                    },
                    textCancel: '取消',
                    onCancel: () {

                    }
                  );
                },
                child: const Text('高级设置'),
              ),
            ],
          ),
          const SizedBox(height: 15),
          FlutterConsole(
            controller: homeController.consoleController,
            height: 300,
            width: size.width,
          ),
        ],
      ),
    );
  }
}
