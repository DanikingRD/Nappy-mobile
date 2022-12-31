import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/constants/database_collections.dart';
import 'package:nappy_mobile/common/exceptions/database_exceptions.dart';
import 'package:nappy_mobile/common/util/logger.dart';
import 'package:nappy_mobile/models/user.dart';
import 'package:nappy_mobile/repositories/interfaces/auth_facade.dart';

extension OptionalUtils<T> on Option<T> {
  T getOrThrow() {
    return getOrElse(() => throw 'How did you end up here? ');
  }
}

extension DatabaseHelper on FirebaseFirestore {
  /// This will give you a [DocumentReference] to the current active user.
  /// If for some reason the user is not authenticated it will throw [NotAuthenticatedError]
  /// crashing the app.
  Future<DocumentReference<User>> getUserDoc(IAuthRepositoryFacade interface) async {
    final optionalUser = interface.getUserIdentifier();
    final identifier = optionalUser.getOrElse(() => throw NotAuthenticatedError());
    return collection(DatabaseCollections.users).doc(identifier.value).withConverter(
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
