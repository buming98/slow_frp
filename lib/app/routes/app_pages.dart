import 'package:get/get.dart';
import 'package:slow_frp/app/modules/frpc/bindings/download_frpc_binding.dart';
import 'package:slow_frp/app/modules/frpc/views/download_frpc_view.dart';
import 'package:slow_frp/app/modules/home/bindings/home_binding.dart';
import 'package:slow_frp/app/modules/splash/bindings/splash_binding.dart';
import 'package:slow_frp/app/modules/splash/views/splash_view.dart';

import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DOWNLOAD_FRPC,
      page: () => const DownloadFrpcView(),
      binding: DownloadFrpcBinding(),
    ),
  ];

}