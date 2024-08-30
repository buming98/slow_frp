import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slow_frp/app/modules/penetrate/controllers/penetrate_config_controller.dart';
import 'package:slow_frp/app/modules/penetrate/views/http_view.dart';
import 'package:slow_frp/app/modules/penetrate/views/stcp_view.dart';
import 'package:slow_frp/app/modules/penetrate/views/stcp_visitor_view.dart';
import 'package:slow_frp/app/modules/penetrate/views/tcp_view.dart';
import 'package:slow_frp/app/modules/penetrate/views/udp_view.dart';

class PenetrateConfigView extends StatelessWidget {

  PenetrateConfigView({super.key});

  final PenetrateConfigController penetrateConfigController = Get.find<PenetrateConfigController>();

  @override
  Widget build(BuildContext context) {
    return ContainedTabBarView(
      tabs: const [
        Text('http'),
        Text('tcp'),
        Text('udp'),
        Text('stcp'),
        Text('stcp-visitor'),
      ],
      tabBarProperties: TabBarProperties(
        width: 500,
        height: 32,
        background: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 0.5,
                blurRadius: 2,
                offset: const Offset(1, -1),
              ),
            ],
          ),
        ),
        position: TabBarPosition.top,
        alignment: TabBarAlignment.start,
        indicatorColor: Colors.transparent,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey[400],
      ),
      views: [
        HttpView(),
        TcpView(),
        UdpView(),
        StcpView(),
        StcpVisitorView(),
      ],
    );

  }
}
