import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:slow_frp/app/components/window_controls.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: WindowBorder(
        color: Colors.black,
        width: 4,
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8, top: 4),
                          child: Text(
                            "SlowFrp",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        MoveWindow(),
                      ],
                    ),
                  ),
                  const WindowControls()
                ],
              ),
            ),
            Expanded(child: widget.child),
          ],
        ),
      )
    );
  }
}
