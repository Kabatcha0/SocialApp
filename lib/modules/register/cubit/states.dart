abstract class RegisterStates {}

class RegisterInitial extends RegisterStates {}

class RegisterValueState extends RegisterStates {}

class RegisterLoading extends RegisterStates {}

class RegisterError extends RegisterStates {
  String? error;
  RegisterError({required this.error});
}

class FirestoreValueState extends RegisterStates {
  final String theUid;
  FirestoreValueState({required this.theUid});
}

class FirestoreLoading extends RegisterStates {}

class FirestoreError extends RegisterStates {
  String? error;
  FirestoreError({required this.error});
}

class SuffixChange extends RegisterStates {}
