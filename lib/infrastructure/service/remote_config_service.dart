import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService._(this._remoteConfig);

  static RemoteConfigService? _instance;

  static Future<RemoteConfigService> getInstance() async {
    if (_instance == null) {
      FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 5),
      ));

      _instance = RemoteConfigService._(remoteConfig);
      await _instance!._fetchAndActivate();
    }

    return _instance!;
  }

  Future<void> _fetchAndActivate() async {
    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      print('Failed to fetch remote config: $e');
    }
  }

  bool get isHideEmail => _remoteConfig.getBool('isHideEmail');
}
