import 'dart:convert';

class UserIdentifier {
  String id;

  UserIdentifier({
    required this.id,
  });

  UserIdentifier copyWith({
    String? id,
  }) {
    return UserIdentifier(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory UserIdentifier.fromMap(Map<String, dynamic> map) {
    return UserIdentifier(
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserIdentifier.fromJson(String source) =>
      UserIdentifier.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(id: $id)';

  @override
  bool operator ==(covariant UserIdentifier other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
