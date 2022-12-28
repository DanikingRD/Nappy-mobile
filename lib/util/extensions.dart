import 'package:fpdart/fpdart.dart';

extension OptionalUtils<T> on Option<T> {
  T getOrThrow() {
    return getOrElse(() => throw 'How did you end up here? ');
  }
}
