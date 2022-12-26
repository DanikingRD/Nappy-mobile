enum EnvType {
  dev,
  testing,
  debugging,
}

/// Environment configuration singleton
class NappyConfig {
  /// The environment type of this instance.
  late final EnvType env;

  // late constructor to set the environment
  factory NappyConfig([EnvType type = EnvType.dev]) {
    _instance.env = type;
    return _instance;
  }
  // Internal constructor
  NappyConfig._internal();

  static final NappyConfig _instance = NappyConfig._internal();

  // Getter for the instance
  static NappyConfig get instance => _instance;

  static bool get isDev => _instance.env == EnvType.dev;
  static bool get isTesting => _instance.env == EnvType.testing;
  static bool get isDebugging => _instance.env == EnvType.debugging;
}
