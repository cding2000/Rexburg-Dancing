import 'package:rexburgdancing/services/auth/auth_exception.dart';
import 'package:rexburgdancing/services/auth/auth_provider.dart';
import 'package:rexburgdancing/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main(){
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('Should not be initiallized at the beginning', () {
      expect(provider.isInitialized, false);
    });
    test('Can not log out before initiallization', () {
      expect(provider.logOut(), throwsA(const TypeMatcher<NotInitializedException>()),);
    });
    test('Should be able to initiallized', () async {
      await provider.initialize();
      expect(provider._isInitialized, true);
    });
    test('User should be null', () {
      expect(provider.currentuser, false);
    });
    test('Initiallize in 2 seconds', () async {
      await provider.initialize();
      expect(provider._isInitialized, true);
    },
      timeout: const Timeout(Duration(seconds: 2)),
    );


  });

}

class NotInitializedException implements Exception{

}

class MockAuthProvider implements AuthProvider{
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({required email, required String password}) async {
    if(!isInitialized) {
      throw NotInitializedException();
    }
    await Future.delayed(const Duration(seconds: 1));
    return logIn(email: email, password: password);

  }

  @override
  // TODO: implement currentuser
  AuthUser? get currentuser => _user;

  @override
  Future<void> initialize() async{
      
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;


  }

  @override
  Future<AuthUser> logIn({required email, required String password}) {
    // TODO: implement logIn
     if(!isInitialized) {
      throw NotInitializedException();
    }
    if(email == '981237897@qq.com') throw UserNotFoundAuthException();
    if(password == "1234561234") throw WrongpasswordAuthException();
    const user = AuthUser(isEmailVerfied: false);
    _user = user;
    return Future.value(user);
    }

  @override
  Future<void> logOut() async {
    // TODO: implement logOut
    if(!isInitialized) {
      throw NotInitializedException();
    }
    if(_user == null){
      throw UserNotFoundAuthException();
    }
    await Future.delayed(const Duration(seconds: 1));
    _user == null;
  }

  @override
  Future<void> sendEmailVerification() async {
    // TODO: implement sendEmailVerification
    if(!isInitialized) {
      throw NotInitializedException();
    }
    final user = _user;
    if(user == null){
      throw UserNotFoundAuthException();
    }
    const newUser = AuthUser(isEmailVerfied: true);
    _user = newUser;


  }

}