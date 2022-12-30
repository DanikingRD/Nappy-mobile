import 'package:nappy_mobile/common/value/identifier.dart';

class User {
  final String email;
  final Identifier id;

  const User({
    required this.email,
    required this.id,
  });

  User copyWith({
    String? email,
    Identifier? id,
  }) {
    return User(
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'id': id.value,
    };
  }

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      email: json['email'] as String,
      id: Identifier.fromUUID(
        json['id'] as String,
      ),
    );
  }

  @override
  String toString() => 'UserModel(email: $email, id: $id)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.email == email && other.id == id;
  }

  @override
  int get hashCode => email.hashCode ^ id.hashCode;
}
