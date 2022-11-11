abstract class LoginStates {}

class LoginInitial extends LoginStates {}

class LoginValueState extends LoginStates {
  final String theUid;
  LoginValueState({required this.theUid});
}

class LoginError extends LoginStates {
  String? error;
  LoginError({required this.error});
}

class SuffixChange extends LoginStates {}

class LoginLoading extends LoginStates {}
