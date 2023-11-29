//login section
class UserNotFoundAuthException implements Exception{  }
class WrongpasswordAuthException implements Exception{  }

// register section
class WeakPasswordAuthException implements Exception{  }
class EmailAlreadyINUseAuthException implements Exception{  }
class InvalidEmailAuthException implements Exception{  }

// gerneric section
class GenericAuthException implements Exception{  }

class UserNotLoggedInAuthException implements Exception{  }
