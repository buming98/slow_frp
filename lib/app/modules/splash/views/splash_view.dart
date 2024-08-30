import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slow_frp/app/layouts/main_layout.dart';
import 'package:slow_frp/app/modules/home/controllers/home_controller.dart';
import 'package:slow_frp/app/modules/splash/controllers/splash_controller.dart';
import 'package:slow_frp/app/routes/app_pages.dart';
import 'package:slow_frp/app/services/tray_service.dart';
import 'package:window_manager/window_manager.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with WindowListener{

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var exists = await Get.find<SplashController>().checkIfFrpcExists();
      if (exists) {
        Get.toNamed(Routes.HOME);
      } else {
        Get.toNamed(Routes.DOWNLOAD_FRPC);
      }
    });
    _init();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void _init() async {
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('SlowFrp加载中...'),
          SizedBox(height: 16),
          CircularProgressIndicator(),
        ],
      ),
    ));
  }

  @override
  void onWindowClose() async {
    await Get.find<HomeController>().stop();
    Get.find<TrayService>().onClose();
    await windowManager.destroy();
  }

}
