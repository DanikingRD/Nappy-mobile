import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/constants/database_collections.dart';
import 'package:nappy_mobile/common/exceptions/database_errors.dart';
import 'package:nappy_mobile/common/value/identifier.dart';
import 'package:nappy_mobile/models/user.dart';
import 'package:nappy_mobile/repositories/interfaces/auth_facade.dart';

extension OptionalUtils<T> on Option<T> {
  T getOrThrow() {
    return getOrElse(() => throw 'How did you end up here? ');
  }
}

extension DatabaseHelper on FirebaseFirestore {
  
  DocumentReference<User> getUserDoc(User user) {
    return getUserDocFrom(user.id);
  }

  DocumentReference<User> getUserDocFrom(Identifier id) {
    return collection(DatabaseCollections.users).doc(id.value).withConverter(
      fromFirestore: (snapshot, options) {
        if (snapshot.data() == null) {
          throw NullDocumentError();
        }
        return User.fromMap(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toMap();
      },
    );
  }
}

extension FirebaseUserIdentifier on auth.User {
  Identifier toIdentifier() {
    return Identifier.fromUUID(uid);
  }
}
