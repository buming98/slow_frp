import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slow_frp/app/layouts/main_layout.dart';
import 'package:slow_frp/app/modules/frpc/controllers/frpc_download_controller.dart';
import 'package:slow_frp/app/routes/app_pages.dart';

class DownloadFrpcView extends GetView<FrpcDownloadController>  {

  const DownloadFrpcView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('糟糕，您的项目中没有frpc'),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
              ),
              child: Obx(() {
                return controller.isLoading.value
                    ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                    : const Text('下载frpc');
              }),
              onPressed: () async {
                try {
                  await controller.downloadFrpc();
                  Get.toNamed(Routes.HOME);
                } catch (e) {
                  Get.defaultDialog(
                    title: "出错误了(T⌓T)",
                    titleStyle: const TextStyle(color: Colors.red),
                    middleText: e.toString(),
                    textConfirm: "关闭",
                    confirmTextColor: Colors.white,
                    onConfirm: () => Get.back(),
                  );
                }
              },
            ),
          ],
       ),
      )
    );
  }
}
