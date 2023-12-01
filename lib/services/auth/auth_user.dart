import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

@immutable
class AuthUser{
  final String? email;
  final bool isEmailVerfied;

  const AuthUser({required this.isEmailVerfied, required this.email});

  factory AuthUser.fromFirebase(User user) => AuthUser(email: user.email, isEmailVerfied: user.emailVerified);

}

