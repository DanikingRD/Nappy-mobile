import 'package:flutter_backend_utils/flutter_backend_utils.dart';
import 'package:fpdart/fpdart.dart';

typedef Success<T> = Right<InvalidValue<String>, String>;
typedef Failure<T> = Left<InvalidValue<String>, String>;
