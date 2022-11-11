import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:socialapp/conponent/components.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/layout/layout.dart';
import 'package:socialapp/modules/login/login.dart';
import 'package:socialapp/shared/const/constant.dart';

class Edit extends StatelessWidget {
  TextEditingController userController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> editKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
        builder: (context, state) {
          userController.text = LayoutCubit.get(context).getModel!.name;
          bioController.text = LayoutCubit.get(context).getModel!.bio;
          phoneController.text = LayoutCubit.get(context).getModel!.phone;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  defaultnavigatorRemove(context, SocialLayout());
                },
                icon: const Icon(Iconsax.arrow_circle_left),
              ),
              title: Text(
                "Edit Profile",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: primary),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: defaultTextButton(
                      function: () {
                        if (editKey.currentState!.validate()) {
                          LayoutCubit.get(context).update(
                              bio: bioController.text,
                              name: userController.text,
                              phone: phoneController.text);
                          defaultnavigatorRemove(context, SocialLayout());
                        }
                      },
                      text: "Update",
                      context: context),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Form(
                key: editKey,
                child: Column(
                  children: [
                    if (state is UploadCoverLoading ||
                        state is UploadProfileLoading)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 250,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    height: 200,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(7),
                                            topRight: Radius.circular(7))),
                                    child: Image(
                                        fit: BoxFit.fitWidth,
                                        image: LayoutCubit.get(context)
                                                    .coverImage ==
                                                null
                                            ? NetworkImage(
                                                LayoutCubit.get(context)
                                                    .getModel!
                                                    .cover) as ImageProvider
                                            : FileImage(LayoutCubit.get(context)
                                                .coverImage!))),
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor: primary,
                                    child: IconButton(
                                        onPressed: () {
                                          LayoutCubit.get(context)
                                              .coverImagePicker();
                                        },
                                        icon: const Icon(
                                          Iconsax.camera,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 51.5,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                    radius: 49,
                                    backgroundImage: LayoutCubit.get(context)
                                                .profileImage ==
                                            null
                                        ? NetworkImage(LayoutCubit.get(context)
                                            .getModel!
                                            .image) as ImageProvider
                                        : FileImage(LayoutCubit.get(context)
                                            .profileImage!)),
                              ),
                              CircleAvatar(
                                radius: 21,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: primary,
                                  child: IconButton(
                                      onPressed: () {
                                        LayoutCubit.get(context)
                                            .profileImagePicker();
                                      },
                                      icon: const Icon(
                                        Iconsax.camera,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (LayoutCubit.get(context).profileImage != null ||
                        LayoutCubit.get(context).coverImage != null)
                      const SizedBox(
                        height: 15,
                      ),
                    Row(children: [
                      if (LayoutCubit.get(context).profileImage != null &&
                          state is! SucessLayout)
                        Expanded(
                            child: Padding(
                          padding:
                              const EdgeInsetsDirectional.only(start: 10.0),
                          child: defaultbutton(
                              function: () {
                                LayoutCubit.get(context).uploadprofileImage(
                                    name: userController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text);
                              },
                              text: "Update profile"),
                        )),
                      // if (LayoutCubit.get(context).profileImage != null &&
                      //     LayoutCubit.get(context).coverImage != null)
                      const SizedBox(
                        width: 10,
                      ),
                      if (LayoutCubit.get(context).coverImage != null &&
                          state is! SucessLayout)
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 10.0),
                          child: defaultbutton(
                              function: () {
                                LayoutCubit.get(context).uploadCoverImage(
                                    name: userController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text);
                              },
                              text: "Update cover"),
                        )),
                    ]),
                    if (LayoutCubit.get(context).profileImage != null ||
                        LayoutCubit.get(context).coverImage != null)
                      const SizedBox(
                        height: 15,
                      ),
                    if (LayoutCubit.get(context).profileImage == null &&
                        LayoutCubit.get(context).coverImage == null)
                      const SizedBox(
                        height: 10,
                      ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      child: defaultTextFormField(
                          function: (val) {
                            if (val!.isEmpty) {
                              return " please write your name";
                            }
                            return null;
                          },
                          icon: Iconsax.user,
                          text: "name",
                          control: userController),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      child: defaultTextFormField(
                          function: (val) {
                            if (val!.isEmpty) {
                              return " please write your bio";
                            }
                            return null;
                          },
                          icon: Iconsax.information,
                          text: "bio",
                          control: bioController),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      child: defaultTextFormField(
                          function: (val) {
                            if (val!.isEmpty) {
                              return " please write your Phone";
                            }
                            return null;
                          },
                          icon: Iconsax.mobile,
                          text: "Phone",
                          control: phoneController),
                    ),
                    OutlinedButton(
                        onPressed: () {
                          defaultnavigatorRemove(context, Login());
                        },
                        child: Text(
                          "LogOut",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: primary),
                        ))
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
