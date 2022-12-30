import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/error/database_error.dart';
import 'package:nappy_mobile/common/value/identifier.dart';
import 'package:nappy_mobile/models/user.dart';

abstract class IUserFacade {
  const IUserFacade();
  Stream<User> watch(Identifier id);

  Future<Either<DatabaseError, Unit>> create(User user);
}
