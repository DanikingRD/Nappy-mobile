import 'package:flutter_backend_utils/invalid_values.dart';
import 'package:flutter_backend_utils/non_illegal_value.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class UniqueIdentifier<T> extends NonIllegalValue<String> {
  final Either<InvalidValue<String>, String> val;

  factory UniqueIdentifier() {
    return UniqueIdentifier._(right(const Uuid().v4()));
  }

  factory UniqueIdentifier.fromUUID(String uuid) {
    return UniqueIdentifier._(right(uuid));
  }

  const UniqueIdentifier._(this.val);

  @override
  Either<InvalidValue<String>, String> get value => val;
}
