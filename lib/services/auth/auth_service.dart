import 'auth_user.dart';
import 'auth_provider.dart';

class AuthSerice implements AuthProvider{
  final AuthProvider provider;
  const AuthSerice(this.provider);
  
  @override
  Future<AuthUser> createUser({required email, required String password})  =>
      provider.createUser(
        email: email,
        password: password,
      );
  
  @override
  // TODO: implement currentuser
  AuthUser? get currentuser => provider.currentuser;
  @override
  Future<AuthUser> logIn({required email, required String password})  =>
      provider.logIn(
        email: email,
        password: password,
      );
  
  @override
  Future<void> logOut() => provider.logOut();
  
  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();


}