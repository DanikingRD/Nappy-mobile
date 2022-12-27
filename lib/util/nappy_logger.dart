import 'package:logger/logger.dart';
import 'package:nappy_mobile/config.dart';

class NappyLogger {
  const NappyLogger._();

  static Logger getLogger(String className) {
    final Level level;
    if (NappyConfig.isDebugging) {
      level = Level.debug;
    } else {
      level = Level.info;
    }
    return Logger(
      printer: NappyLoggerPrinter(
        className: className,
      ),
      level: level,
    );
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
