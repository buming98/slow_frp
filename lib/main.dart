import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import 'app/routes/app_pages.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITAL,
      getPages: AppPages.routes,
    ),
  );

  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1024, 750);
    win.minSize = initialSize;
    win.maxSize = const Size(1920, 1080);
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "SlowFrp";
    win.show();
  });

}
