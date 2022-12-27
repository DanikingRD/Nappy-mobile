enum EnvType {
  development,
  testing,
  debugging,
}

/// Environment configuration singleton
class NappyConfig {
  /// The environment type of this instance.
  late final EnvType env;
  late final String appName;

  // late constructor to set the environment
  factory NappyConfig(String appName, [EnvType type = EnvType.development]) {
    _instance.env = type;
    _instance.appName = appName;
    return _instance;
  }
  // Internal constructor
  NappyConfig._internal();

  static final NappyConfig _instance = NappyConfig._internal();

  // Getter for the instance
  static NappyConfig get instance => _instance;

  static bool get isDev => _instance.env == EnvType.development;
  static bool get isTesting => _instance.env == EnvType.testing;
  static bool get isDebugging => _instance.env == EnvType.debugging;
}
