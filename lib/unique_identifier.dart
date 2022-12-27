import 'package:nappy_mobile/value/value.dart';
import 'package:uuid/uuid.dart';

class UniqueIdentifier<T> extends Value<String> {

  factory UniqueIdentifier() {
    return UniqueIdentifier._(const Uuid().v4());
  }


  const UniqueIdentifier._(super.uuid);

}
