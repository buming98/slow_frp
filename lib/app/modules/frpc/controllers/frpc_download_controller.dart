import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:slow_frp/app/constants/frpc_constants.dart';
import 'package:slow_frp/app/modules/frpc/models/github_release/github_release.dart';
import 'package:slow_frp/app/modules/frpc/service/ApiService.dart';
import 'package:slow_frp/app/util/PathUtils.dart';

class FrpcDownloadController extends GetxController with StateMixin<dynamic> {

  var isLoading = false.obs;

  Future<void> downloadFrpc() async {
    isLoading(true);
    try {
      if (Platform.isWindows) {
        await downloadFrpcWindows();
      } else if (Platform.isMacOS){
        await downloadFrpcMacOS();
      } else if (Platform.isLinux) {
        await downloadFrpcLinux();
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> downloadFrpcWindows() async {
    GithubRelease? githubRelease = await ApiService.fetchGithubRelease();
    if (githubRelease== null || githubRelease.assets == null) {
      return;
    }
    var windowsAsset = githubRelease.assets!.firstWhere((element) => element.name!.contains('windows_amd64.zip'));
    var tempDir = Directory.systemTemp;
    await ApiService.downloadFrp(windowsAsset.browserDownloadUrl!, "${tempDir.path}\\windows_amd64.zip");
    var file = File("${tempDir.path}\\windows_amd64.zip");
    var zip = ZipDecoder();
    var archive = zip.decodeBytes(file.readAsBytesSync());
    var frpcPath = await PathUtils.getFrpcPath();
    for (final file in archive) {
      final filename = file.name;
      if (file.isFile && filename.endsWith("frpc.exe")) {
        final data = file.content as List<int>;
        File(frpcPath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      }
    }
    // delete temp file
    file.deleteSync();
  }

  Future<void> downloadFrpcMacOS() async {
    GithubRelease? githubRelease = await ApiService.fetchGithubRelease();
    if (githubRelease== null || githubRelease.assets == null) {
      return;
    }
    var macOSAsset = githubRelease.assets!.firstWhere((element) => element.name!.contains('darwin_amd64.tar.gz'));
    print(macOSAsset);
    var tempDir = Directory.systemTemp;
    await ApiService.downloadFrp(macOSAsset.browserDownloadUrl!, "${tempDir.path}/frp.tar.gz");
    var tempFile = File("${tempDir.path}/frp.tar.gz");
    var tarBytes = GZipDecoder().decodeBytes(tempFile.readAsBytesSync());
    var archive = TarDecoder().decodeBytes(tarBytes);
    var frpcPath = await PathUtils.getFrpcPath();
    for (final file in archive) {
      final filename = file.name;
      if (file.isFile && filename.endsWith(frpcExecutable)) {
        final data = file.content as List<int>;
        File(frpcPath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      }
    }
    tempFile.deleteSync();
    Process.runSync('chmod', ['+x', frpcPath]);
  }

  Future<void> downloadFrpcLinux() async {
    GithubRelease? githubRelease = await ApiService.fetchGithubRelease();
    if (githubRelease== null || githubRelease.assets == null) {
      return;
    }
    var linuxAsset = githubRelease.assets!.firstWhere((element) => element.name!.contains('linux_amd64.tar.gz'));
    var tempDir = Directory.systemTemp;
    await Dio().download(linuxAsset.browserDownloadUrl!, "${tempDir.path}/frp.zip");
    var tempFile = File("${tempDir.path}/frp.tar.gz");
    var tarBytes = GZipDecoder().decodeBytes(tempFile.readAsBytesSync());
    var archive = TarDecoder().decodeBytes(tarBytes);
    for (final file in archive) {
      final filename = file.name;
      if (file.isFile && filename.endsWith(frpcExecutable)) {
        final data = file.content as List<int>;
        File(frpcPath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      }
    }
    tempFile.deleteSync();
    Process.runSync('chmod', ['+x', frpcPath]);
  }

}
