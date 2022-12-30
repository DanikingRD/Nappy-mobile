import 'package:flutter/cupertino.dart';

/// Represents an immutable abstract value whose illegal state is unrepresentable.
/// This is also known as a `ValueObject` in the Domain-Driven Design.
///
/// Here are some examples for reference:
///
/// - [EmailAddressValue]
/// - [PasswordValue]
@immutable
abstract class Value<T> {
  /// Contained value.
  final T value;

  /// Constructs a new value with a non illegal state.
  const Value(this.value);

  @override
  bool operator ==(covariant Object other) {
    if (identical(this, other)) return true;
    return other is Value<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value(value: $value)';
}
