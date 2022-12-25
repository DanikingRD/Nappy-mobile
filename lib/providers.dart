import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nappy_mobile/auth_repository.dart';
import 'package:nappy_mobile/features/auth/controllers/login_controller.dart';

final authProvider = Provider((ref) => FirebaseAuth.instance);
final googleProvider = Provider((ref) => GoogleSignIn());
final authRepositoryProvider = Provider((ref) {
  final auth = ref.read(authProvider);
  final google = ref.read(googleProvider);
  return NappyAuthRepository(auth, google);
});
final loginControllerProvider = StateNotifierProvider((ref) {
  return LoginController(ref.read(authRepositoryProvider));
});
