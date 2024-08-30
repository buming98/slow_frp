import 'package:dio/dio.dart';
import 'package:slow_frp/app/constants/frpc_constants.dart';
import 'package:slow_frp/app/modules/frpc/models/github_release/github_release.dart';

class ApiService {

  static Future<GithubRelease?> fetchGithubRelease() async {
    var response = await Dio().get(githubReleasesLatestUrl);
    if (response.statusCode == 200) {
      return GithubRelease.fromMap(response.data);
    }
    return null;
  }

  static Future<void> downloadFrp(String downloadUrl, String savePath) async {
    await Dio().download(downloadUrl, savePath);
  }

}