import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {

  AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage("assets/images/app_icon.png"),
            width: 50,
            height: 50,
          ),
          const Text(
            'SlowFrp',
            style: TextStyle(
                fontSize: 30.0,
            ),
          ),
          const Text(
            '版本 1.0.0',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '作者 小标快跑',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              FadeInImage.assetNetwork(
                image: 'https://www.notming.com/img/avatar.jpeg',
                width: 25,
                height: 25,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset("assets/images/defaultHeader.jpeg");
                },
                placeholder: 'assets/images/app_icon.png',
              ),
            ],
          ),
          TextButton(
            onPressed: ()=>_launchUrl(Uri.parse('https://www.notming.com/')),
            child: const Text('个人博客 www.notming.com'),
          ),
          const Text(
            '联系邮箱 1340595077@qq.com',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          TextButton(
            onPressed: ()=>_launchUrl(Uri.parse('https://gofrp.org')),
            child: const Text('本项目基于FRP'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(Uri uri) async {
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

}
