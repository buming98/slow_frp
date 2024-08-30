import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class ObjectUtils {

  static Map<String, PlutoCell> copyPlutoCell(Map<String, PlutoCell> srcMap){
    Map<String, PlutoCell> obj = json.decode(json.encode(srcMap));
    debugPrint("拷贝：${obj.keys.toString()}");
    return obj;
  }

}