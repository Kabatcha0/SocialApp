import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:socialapp/conponent/components.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/modules/edit/edit.dart';
import 'package:socialapp/shared/const/constant.dart';
import 'package:socialapp/shared/style/themes.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
        builder: (context, state) => Padding(
              padding: const EdgeInsets.only(top: 0.0, right: 5, left: 5),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    height: 250,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: 200,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(7),
                                      topRight: Radius.circular(7))),
                              child: Image(
                                  fit: BoxFit.fitWidth,
                                  image: NetworkImage(LayoutCubit.get(context)
                                      .getModel!
                                      .cover))),
                        ),
                        CircleAvatar(
                          radius: 51.5,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                              radius: 49,
                              backgroundImage: NetworkImage(
                                  LayoutCubit.get(context).getModel!.image)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          LayoutCubit.get(context).getModel!.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: primary),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          LayoutCubit.get(context).getModel!.bio,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 16, color: primary),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    "135",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: primary),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "Posts",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: primary),
                                  ),
                                ],
                              )),
                        ),
                        Expanded(
                          child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    "50",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: primary),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "Photos",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: primary),
                                  ),
                                ],
                              )),
                        ),
                        Expanded(
                          child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    "10K",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: primary),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "Followers",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: primary),
                                  ),
                                ],
                              )),
                        ),
                        Expanded(
                          child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    "35",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: primary),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "Following",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: primary),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: OutlinedButton(
                              onPressed: () {},
                              child: Text(
                                "Edit your profile",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: primary),
                              ))),
                      const SizedBox(
                        width: 10,
                      ),
                      OutlinedButton(
                          onPressed: () {
                            defaultnavigator(context, Edit());
                          },
                          child: const Icon(Iconsax.pen_add))
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: OutlinedButton(
                        child: const Text(
                          "subscribe",
                          style: TextStyle(color: primary),
                        ),
                        onPressed: () {
                          FirebaseMessaging.instance.subscribeToTopic("anon");
                        },
                      )),
                      const SizedBox(
                        width: 7,
                      ),
                      Expanded(
                          child: OutlinedButton(
                        child: const Text(
                          "unsubscribe",
                          style: TextStyle(color: primary),
                        ),
                        onPressed: () {
                          FirebaseMessaging.instance
                              .unsubscribeFromTopic("anon");
                        },
                      )),
                    ],
                  )
                ],
              )),
            ),
        listener: (context, state) {});
  }
}
