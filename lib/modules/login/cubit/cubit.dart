import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  IconData icon = Icons.visibility;
  bool isEye = true;
  void changeEye() {
    isEye = !isEye;
    icon = isEye ? Icons.visibility_off : Icons.visibility;
    emit(SuffixChange());
  }

  void openAccount({
    required String email,
    required String password,
  }) {
    emit(LoginLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.uid);
      print(value.user!.email);
      emit(LoginValueState(theUid: value.user!.uid));
    }).catchError((onError) {
      emit(LoginError(error: onError.toString()));
      print("the Mohamed ${onError.toString()}");
    });
  }
}
