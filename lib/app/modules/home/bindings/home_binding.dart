import 'package:get/get.dart';
import 'package:slow_frp/app/modules/home/controllers/home_controller.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/http_controller.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/penetrate_config_controller.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/stcp_controller.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/stcp_visitor_controller.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/tcp_controller.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/udp_controller.dart';
import 'package:slow_frp/app/modules/server/controllers/server_config_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<ServerConfigController>(
          () => ServerConfigController(),
    );
    Get.lazyPut<PenetrateConfigController>(
          () => PenetrateConfigController(),
    );
    Get.put<HttpController>(
      HttpController(),
    );
    Get.put<TcpController>(
      TcpController(),
    );
    Get.put<UdpController>(
      UdpController(),
    );
    Get.put<StcpController>(
      StcpController(),
    );
    Get.put<StcpVisitorController>(
      StcpVisitorController(),
    );
  }
}
