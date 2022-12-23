import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/errors.dart';

@immutable
abstract class NonNullValue<T> {
  const NonNullValue();

  Either<ValueError<T>, T> get value;

  @override
  bool operator ==(covariant Object other) {
    if (identical(this, other)) return true;
    return other is NonNullValue<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'NonNullValue(value: $value)';
}
