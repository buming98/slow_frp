import 'package:get/get.dart';
import 'package:slow_frp/app/modules/home/controllers/home_controller.dart';
import 'package:slow_frp/app/modules/splash/controllers/splash_controller.dart';
import 'package:slow_frp/app/services/tray_service.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
          () => SplashController(),
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<TrayService>(
          () => TrayService(),
    );
  }
}
