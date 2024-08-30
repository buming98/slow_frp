

import 'package:flutter/material.dart';
import 'package:slow_frp/app/modules/about/views/about.dart';
import 'package:slow_frp/app/modules/home/views/home_tab_view.dart';
import 'package:slow_frp/app/modules/penetrate/views/penetrate_config.dart';
import 'package:slow_frp/app/modules/server/views/server_config.dart';

final List<Widget> tabViewList = [HomeTabView(), ServerConfigView(), PenetrateConfigView(), AboutView()];

const canvasColor = Colors.white;
const white = Colors.white;
final divider = Divider(color: white.withOpacity(0.3), height: 1);

