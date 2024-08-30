import 'dart:io';

final frpcExecutable = Platform.isWindows ? 'frpc.exe' : 'frpc';

final frpcPath = "frp/$frpcExecutable";

final githubReleasesLatestUrl = "https://api.github.com/repos/fatedier/frp/releases/latest";

final frpcConfigPath = "frp/frpc.ini";

