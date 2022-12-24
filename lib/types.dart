import 'package:flutter_backend_utils/errors.dart';
import 'package:fpdart/fpdart.dart';

// TODO: find a better name for this type as this does not always
// represents the result of some processing.
typedef Result<T> = Either<ValueError<T>, T>;
