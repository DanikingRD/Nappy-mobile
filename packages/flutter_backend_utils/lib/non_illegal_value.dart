import 'package:flutter/cupertino.dart';
import 'package:flutter_backend_utils/invalid_values.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_backend_utils/value_objects.dart';

/// Represents an immutable abstract value whose illegal state is unrepresentable.
/// This is also known as a `ValueObject` in the Domain-Driven Design.
///
/// This value is hold by an [Either] type, the left-side containing the possible
/// [InvalidValue] and the right-side the actual value [T].
///
/// Implementation is lead to the user. You must validate the value in the constructor.
/// Here are some examples for reference:
///
/// - [EmailAddressValue]
/// - [PasswordValue]
@immutable
abstract class NonIllegalValue<T> {
  /// Constructs a new value with a non illegal state.
  const NonIllegalValue();

  /// Contained value.
  /// It can be one of two possible types, [InvalidValue] or [T].
  Either<InvalidValue<T>, T> get value;

  /// Return the value inside this [NonIllegalValue] if it is valid.
  /// Otherwise it will throw an [IllegalValueError] containing the [InvalidValue].
  T getOrThrow() => value.getOrElse((invalid) => throw IllegalValueError(invalid));

  /// Returns whether the contained value is non-illegal, in other words
  /// it is a valid value.
  bool isOk() => value.isRight();

  /// Returns whether the contained value is illegal, thus a [InvalidValue]
  bool isErr() => value.isLeft();

  @override
  bool operator ==(covariant Object other) {
    if (identical(this, other)) return true;
    return other is NonIllegalValue<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'NonNullValue(value: $value)';
}
