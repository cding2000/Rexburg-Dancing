import 'auth_user.dart';
import 'auth_provider.dart';
import 'firebase_auth_provider.dart';

class AuthService implements AuthProvider{
  final AuthProvider provider;
  const AuthService(this.provider);
  
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  
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
  
  @override
  Future<void> initialize()  => provider.initialize();

}