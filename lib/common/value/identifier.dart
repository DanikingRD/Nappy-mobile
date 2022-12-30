import 'package:nappy_mobile/common/value/value.dart';
import 'package:uuid/uuid.dart';

class Identifier extends Value<String> {
  factory Identifier() {
    return Identifier._(const Uuid().v4());
  }

  factory Identifier.fromUUID(String uuid) {
    assert(uuid.isNotEmpty);
    return Identifier._(uuid);
  }

  const Identifier._(super.value);
}
