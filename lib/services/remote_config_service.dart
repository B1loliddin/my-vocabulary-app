import 'package:firebase_remote_config/firebase_remote_config.dart';

sealed class RemoteConfigService {
  static final remoteConfig = FirebaseRemoteConfig.instance;

  static Future<void> init() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 1),
        minimumFetchInterval: const Duration(seconds: 1),
      ),
    );

    await remoteConfig.setDefaults(
      {
        'season': Season.winter.name,
      },
    );
  }

  static String get season => remoteConfig.getString('season');

  static Future<void> activate() async => await remoteConfig.fetchAndActivate();
}

enum Season {
  winter,
  spring,
  summer,
  autumn,
}
