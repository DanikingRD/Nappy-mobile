import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authProvider = Provider((ref) => FirebaseAuth.instance, name: "FirebaseAuth");
final googleProvider = Provider((ref) => GoogleSignIn(), name: "GoogleAuthProvider");
final databaseProvider = Provider((ref) => FirebaseFirestore.instance, name: "CloudFirestore");
