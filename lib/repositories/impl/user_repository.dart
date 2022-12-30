import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/errors/database_error.dart';
import 'package:nappy_mobile/common/global_providers.dart';
import 'package:nappy_mobile/common/util/extensions.dart';
import 'package:nappy_mobile/common/util/logger.dart';
import 'package:nappy_mobile/common/value/identifier.dart';
import 'package:nappy_mobile/models/user.dart';
import 'package:nappy_mobile/repositories/impl/auth_repository.dart';
import 'package:nappy_mobile/repositories/interfaces/auth_facade.dart';
import 'package:nappy_mobile/repositories/interfaces/user_facade.dart';

final userRepositoryProvider = Provider<IUserFacade>((ref) {
  return UserRepositoryImpl(
    database: ref.read(databaseProvider),
    authRepository: ref.read(authRepositoryProvider),
    logger: NappyLogger.getLogger((UserRepositoryImpl).toString()),
  );
});

class UserRepositoryImpl extends IUserFacade {
  final FirebaseFirestore _database;
  final IAuthRepositoryFacade _authRepository;
  final NappyLogger _logger;

  const UserRepositoryImpl({
    required FirebaseFirestore database,
    required NappyLogger logger,
    required IAuthRepositoryFacade authRepository,
  })  : _database = database,
        _logger = logger,
        _authRepository = authRepository;

  @override
  Stream<User> watch(Identifier id) {
    // TODO: implement watchUser
    throw UnimplementedError();
  }

  @override
  Future<Either<DatabaseError, Unit>> create(User user) async {
    try {
      final doc = await _database.getUserDoc(_authRepository);
      await doc.set(user);
      return right(unit);
    } on FirebaseException catch (e) {
      return left(DatabaseErrorHelper.getByCode(e.code));
    } catch (e) {
      return left(DatabaseError.unableToUpdate);
    }
  }
}
