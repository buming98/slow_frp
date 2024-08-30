import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:slow_frp/app/layouts/main_layout.dart';
import 'package:slow_frp/app/modules/home/constants/home_constants.dart';

class HomeView extends StatefulWidget {

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeView();
}

class _HomeView  extends State<HomeView>  {

  final sidebarController = SidebarXController(selectedIndex: 0, extended: true);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MainLayout(
      child: Scaffold(
        body: Row(
          children: [
            SidebarX(
              controller: sidebarController,
              extendedTheme: const SidebarXTheme(
                width: 200,
                decoration: BoxDecoration(
                  color: canvasColor,
                ),
                margin: EdgeInsets.only(right: 10),
              ),
              footerDivider: divider,
              headerBuilder: (context, extended) {
                return SizedBox(
                  height: 50,
                  child: Image.asset('assets/images/app_icon.png'),
                );
              },
              items: [
                SidebarXItem(
                  icon: Icons.home,
                  label: '主页',
                  onTap: () {

                  },
                ),
                const SidebarXItem(
                  icon: Icons.electrical_services,
                  label: '服务器连接配置',
                ),
                const SidebarXItem(
                  icon: Icons.list,
                  label: '应用穿透配置',
                ),
                const SidebarXItem(
                  icon: Icons.person,
                  label: '关于我们',
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: AnimatedBuilder(
                  animation: sidebarController,
                  builder: (context, child) {
                    switch (sidebarController.selectedIndex) {
                      case 0:
                        return tabViewList[0];
                      case 1:
                        return tabViewList[1];
                      case 2:
                        return tabViewList[2];
                      case 3:
                        return tabViewList[3];
                      default:
                        return Text(
                          'Not found page',
                          style: theme.textTheme.headlineSmall,
                        );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}