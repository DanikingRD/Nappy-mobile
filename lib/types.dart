import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/errors.dart';

// TODO: find a better name for this type as this does not always
// represents the result of some processing.
typedef Result<T> = Either<ValueError<T>, T>;
