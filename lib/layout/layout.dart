import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:socialapp/conponent/components.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: LayoutCubit.get(context)
                          .title[LayoutCubit.get(context).currentIndex] ==
                      LayoutCubit.get(context).title[2]
                  ? null
                  : Text(
                      LayoutCubit.get(context)
                          .title[LayoutCubit.get(context).currentIndex],
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 18),
                    ),
              actions: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Iconsax.notification)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Iconsax.search_normal)),
              ],
            ),
            body: LayoutCubit.get(context)
                .changeScreen[LayoutCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: LayoutCubit.get(context).currentIndex,
                onTap: (int index) {
                  LayoutCubit.get(context).onTap(index, context);
                },
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Iconsax.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Iconsax.message), label: "Chat"),
                  BottomNavigationBarItem(
                      icon: Icon(Iconsax.add), label: "Post"),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.map),
                    label: "Map",
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Iconsax.setting), label: "Setting"),
                ]),
          );
        });
  }
}
// ConditionalBuilder(
//                 condition: LayoutCubit.get(context).model != null,
//                 builder: (context) {
//                   final bool model =
//                       FirebaseAuth.instance.currentUser!.emailVerified;
//                   print(model);
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 20.0, bottom: 20),
//                     child: Column(
//                       children: [
//                         if (!model)
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             color: Colors.yellow.withOpacity(0.6),
//                             child: Row(
//                               children: [
//                                 const Icon(
//                                   Iconsax.home,
//                                 ),
//                                 const SizedBox(
//                                   width: 5,
//                                 ),
//                                 Expanded(
//                                   child: Text(
//                                     "Please verify ",
//                                     style:
//                                         Theme.of(context).textTheme.bodyText2,
//                                   ),
//                                 ),
//                                 const Spacer(),
//                                 defaultTextButton(
//                                     function: () {
//                                       FirebaseAuth.instance.currentUser!
//                                           .sendEmailVerification()
//                                           .then((value) {
//                                         changeColor(
//                                             msg: "go to Check",
//                                             state: ToastState.error);
//                                       }).catchError((error) {
//                                         print(error);
//                                       });
//                                     },
//                                     text: "Send",
//                                     context: context)
//                               ],
//                             ),
//                           ),
//                       ],
//                     ),
//                   );
//                 },
//                 fallback: (context) => const Center(
//                       child: CircularProgressIndicator(),
//                     )),
