import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/errors/database_error.dart';
import 'package:nappy_mobile/common/util/types.dart';
import 'package:nappy_mobile/common/value/identifier.dart';
import 'package:nappy_mobile/models/user.dart';

typedef AsyncDatabaseResult<T> = FutureResult<DatabaseError, T>;

abstract class IUserFacade {
  const IUserFacade();
  Stream<User> watch(Identifier id);

  AsyncDatabaseResult<Unit> create(User user);
}
