import 'package:get/get.dart';
import 'package:slow_frp/app/modules/frpc/controllers/frpc_download_controller.dart';

class DownloadFrpcBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FrpcDownloadController>(
      () => FrpcDownloadController(),
    );
  }
}
