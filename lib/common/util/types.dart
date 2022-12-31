import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

typedef Result<T, E> = Either<E, T>;
typedef FutureResult<T, E> = Future<Result<E, T>>;