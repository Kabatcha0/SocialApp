import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/firestoreregister.dart';
import 'package:socialapp/modules/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  IconData icon = Icons.visibility;
  bool isEye = true;
  void changeEye() {
    isEye = !isEye;
    icon = isEye ? Icons.visibility_off : Icons.visibility;
    emit(SuffixChange());
  }

  void createAccount({
    required String email,
    required String password,
    required String phone,
    required String name,
    // required String bio,
    // required String cover,
    // required String image,
  }) {
    emit(RegisterLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      storeAccount(
        uid: value.user!.uid,
        email: email,
        password: password,
        phone: phone,
        name: name,
        // bio: bio,
        // cover: cover,
        // image: image
      );
    }).catchError((onError) {
      emit(RegisterError(error: onError));
    });
  }

  void storeAccount({
    required String uid,
    required String email,
    required String password,
    required String phone,
    required String name,
    // required String bio,
    // required String cover,
    // required String image,
  }) {
    FireStoreRegister model = FireStoreRegister(
        email: email,
        name: name,
        password: password,
        phone: phone,
        uid: uid,
        bio: "Ur bio ...",
        cover:
            "https://img.freepik.com/free-psd/arrangement-minimal-coffee-mugs_23-2149027126.jpg?w=740&t=st=1666808682~exp=1666809282~hmac=9aae4b4d426fd99d2e3d4ea0e061df68e153d22bd8613f4053802aeca5f725db",
        image:
            "https://img.freepik.com/premium-photo/young-arab-man-isolated-beige-background-smiles-pointing-fingers-mouth_1187-210769.jpg?w=740");
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(FirestoreValueState(theUid: uid));
    }).catchError((onError) {
      emit(FirestoreError(error: onError));
    });
  }
}
