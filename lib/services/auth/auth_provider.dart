import 'auth_user.dart';

abstract class AuthProvider{
  AuthUser? get currentuser;

  Future<AuthUser> logIn({
    required email,
    required String password,}
  );
  Future<AuthUser> createUser({
    required email,
    required String password,}
  );
  
  Future <void> logOut();
  Future <void> sendEmailVerification();
}

