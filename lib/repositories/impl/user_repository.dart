import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/exceptions/backend_error_mapping.dart';
import 'package:nappy_mobile/common/global_providers.dart';
import 'package:nappy_mobile/common/util/extensions.dart';
import 'package:nappy_mobile/common/util/logger.dart';
import 'package:nappy_mobile/common/value/identifier.dart';
import 'package:nappy_mobile/models/user.dart';
import 'package:nappy_mobile/repositories/interfaces/user_facade.dart';

/// Provides the data of the logged in user.
final userProvider = StateProvider<Option<User>>((ref) => Option.none(), name: "UserProvider");

final userRepositoryProvider = Provider<IUserFacade>(
  (ref) {
    return UserRepositoryImpl(
      database: ref.read(databaseProvider),
      logger: NappyLogger.getLogger((UserRepositoryImpl).toString()),
    );
  },
  name: (UserRepositoryImpl).toString(),
);

class UserRepositoryImpl extends IUserFacade {
  final FirebaseFirestore _database;
  final NappyLogger _logger;

  const UserRepositoryImpl({
    required FirebaseFirestore database,
    required NappyLogger logger,
  })  : _database = database,
        _logger = logger;

  @override
  Stream<User> watch(Identifier id) {
    return _database
        .getUserDocFrom(id)
        .snapshots()
        .map((event) => event.data()!); // This can't be null
  }

  @override
  Future<Either<BackendError, Unit>> create(User user) async {
    try {
      final doc = _database.getUserDoc(user);
      await doc.set(user);
      return right(unit);
    } on FirebaseException catch (e) {
      return left(DatabaseError.mapCode(e.code));
    } catch (e) {
      return left(DatabaseError.unknown);
    }
  }

  @override
  AsyncDatabaseResult<User> read(Identifier id) async {
    try {
      final doc = _database.getUserDocFrom(id);
      final user = await doc.get();
      return right(user.data()!);
    } on FirebaseException catch (e) {
      return left(DatabaseError.mapCode(e.code));
    } catch (e) {
      return left(DatabaseError.unknown);
    }
  }
}
