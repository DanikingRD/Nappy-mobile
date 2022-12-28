import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:nappy_mobile/config.dart';

class NappyLogger extends Logger {
  NappyLogger._({
    required LogPrinter printer,
    required Level level,
  }) : super(printer: printer, level: level);

  /// Log debugging exceptions
  void handleDebugLog({
    required String element,
    required String code,
    required String desc,
  }) {
    d('[$element] has thrown exception code [$code]: $desc');
  }

  static NappyLogger getLogger(String className) {
    final Level level;
    if (NappyConfig.isDebugging) {
      level = Level.debug;
    } else {
      level = Level.info;
    }
    return NappyLogger._(
      printer: NappyLoggerPrinter(
        className: className,
      ),
      level: level,
    );
  }
}

class NappyProviderObserver extends ProviderObserver {
  const NappyProviderObserver() : super();
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    NappyLogger.getLogger(provider.name ?? 'provider').d('New State: $newValue');
  }
}

class NappyLoggerPrinter extends LogPrinter {
  final String className;
  NappyLoggerPrinter({
    required this.className,
  });

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level];
    final emoji = PrettyPrinter.levelEmojis[event.level]!;
    final emojiOutput = emoji.replaceAll(' ', '');
    final message = event.message;
    final time = DateTime.now();
    return [
      color!(
        "[${time.hour}:${time.minute}:${time.second}] [$className/${event.level.name.toUpperCase()}]$emojiOutput: $message",
      ),
    ];
  }
}
