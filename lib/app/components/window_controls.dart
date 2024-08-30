import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slow_frp/app/modules/home/controllers/frpc_controller.dart';
import 'package:slow_frp/app/services/tray_service.dart';

final buttonColors = WindowButtonColors(
  iconNormal: Colors.black,
  mouseOver: const Color(0xFFF6A00C),
  mouseDown: const Color(0xFF805306),
  iconMouseOver: Colors.black,
  iconMouseDown: const Color(
    0xFFFFD500,
  ),
);

final closeButtonColors = WindowButtonColors(
  mouseOver: const Color(0xFFD32F2F),
  mouseDown: const Color(0xFFB71C1C),
  iconNormal: Colors.black,
  iconMouseOver: Colors.black,
);

class WindowControls extends StatefulWidget {
  const WindowControls({super.key});

  @override
  State<WindowControls> createState() => _WindowControlsState();
}

class _WindowControlsState extends State<WindowControls> {
  final FrpcController _frpcController = Get.put<FrpcController>(FrpcController());
  final TrayService _trayService = Get.put<TrayService>(TrayService());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Tooltip(
          message: "隐藏到托盘",
          child: MinimizeWindowButton(
            colors: buttonColors,
            onPressed: () {
              appWindow.hide();
              _trayService.addShowMenuItem();
            },
          )
        ),
        MaximizeWindowButton(colors: buttonColors),
        Tooltip(
          message: "关闭",
          child: CloseWindowButton(
            colors: closeButtonColors,
          ),
        ),
      ],
    );
  }
}
