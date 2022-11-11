import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/conponent/components.dart';
import 'package:socialapp/layout/layout.dart';
import 'package:socialapp/modules/login/cubit/cubit.dart';
import 'package:socialapp/modules/login/cubit/states.dart';
import 'package:socialapp/modules/register/cubit/states.dart';
import 'package:socialapp/modules/register/register.dart';
import 'package:socialapp/shared/const/constant.dart';
import 'package:socialapp/shared/network/local/cachehelper.dart';

class Login extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          builder: (context, state) => Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Login",
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
                            control: pass,
                            type: TextInputType.emailAddress,
                            sicon: LoginCubit.get(context).icon,
                            obscure: LoginCubit.get(context).isEye,
                            suffixpressed: () {
                              LoginCubit.get(context).changeEye();
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ConditionalBuilder(
                              builder: (context) => defaultbutton(
                                  function: () {
                                    LoginCubit.get(context).openAccount(
                                        email: email.text, password: pass.text);
                                  },
                                  text: "Login"),
                              fallback: (context) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                              condition: state is! LoginLoading),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "don't have any account?",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              defaultTextButton(
                                  function: () {
                                    defaultnavigator(context, Register());
                                  },
                                  text: "Register",
                                  context: context)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          listener: (context, state) {
            if (state is LoginError) {
              changeColor(msg: state.error!, state: ToastState.error);
            }
            if (state is LoginValueState) {
              CacheHelper.setData(key: "UID", value: state.theUid)!
                  .then((value) {
                uiD = state.theUid;
                defaultnavigatorRemove(context, SocialLayout());
              });
              print(uiD);
            }
          }),
    );
  }
}
