import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/conponent/components.dart';
import 'package:socialapp/layout/layout.dart';
import 'package:socialapp/modules/register/cubit/cubit.dart';
import 'package:socialapp/modules/register/cubit/states.dart';
import 'package:socialapp/shared/network/local/cachehelper.dart';

class Register extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterError) {
            changeColor(msg: state.error!, state: ToastState.error);
          }
          if (state is FirestoreValueState) {
            CacheHelper.setData(key: "UID", value: state.theUid)!.then((value) {
              defaultnavigatorRemove(context, SocialLayout());
            });
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Register",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 50),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultTextFormField(
                        icon: Icons.email,
                        isSuffix: false,
                        text: "email",
                        control: email,
                        type: TextInputType.emailAddress),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextFormField(
                      icon: Icons.password,
                      text: "password",
                      type: TextInputType.emailAddress,
                      control: pass,
                      sicon: RegisterCubit.get(context).icon,
                      obscure: RegisterCubit.get(context).isEye,
                      suffixpressed: () {
                        RegisterCubit.get(context).changeEye();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextFormField(
                        icon: Icons.person,
                        isSuffix: false,
                        text: "username",
                        control: username,
                        type: TextInputType.text),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextFormField(
                        icon: Icons.phone,
                        isSuffix: false,
                        text: "phone",
                        control: phone,
                        type: TextInputType.phone),
                    const SizedBox(
                      height: 10,
                    ),
                    ConditionalBuilder(
                      builder: (context) => defaultbutton(
                          function: () {
                            RegisterCubit.get(context).createAccount(
                                email: email.text,
                                password: pass.text,
                                name: username.text,
                                phone: phone.text);
                          },
                          text: "Register"),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      condition: state is! RegisterLoading,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
