import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:nappy_mobile/config.dart';
import 'package:nappy_mobile/nappy.dart';
import 'package:nappy_mobile/util/nappy_logger.dart';

final Logger logger = NappyLogger.getLogger("init");
const String appName = "Nappy";
// This is why I use [Unit] instead of `void`:
// (https://medium.com/flutter-community/the-curious-case-of-void-in-dart-f0535705e529)
Future<Unit> run(EnvType env) async {
  final NappyConfig config = NappyConfig(appName, env);
  logger.i("Initializing Nappy in ${config.env.name} mode");
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  // TODO: init firebase
  runApp(
    const ProviderScope(
      child: Nappy(),
    ),
  );
  return unit;
}
