import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:socialapp/conponent/components.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/models/postmodel.dart';
import 'package:socialapp/modules/writecomment/comment.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      // LayoutCubit.get(context).getPosts();
      return BlocConsumer<LayoutCubit, LayoutStates>(
          builder: (context, state) {
            return ConditionalBuilder(
                condition: LayoutCubit.get(context).posts.isNotEmpty,
                builder: (context) => SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      LayoutCubit.get(context).getModel!.cover),
                                  width: double.infinity,
                                  height: 250,
                                ),
                                elevation: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "communnication with your friends",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => card(context,
                                  LayoutCubit.get(context).posts[index], index),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 4,
                                  ),
                              itemCount: LayoutCubit.get(context).posts.length),
                        ],
                      ),
                    )),
                fallback: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ));
          },
          listener: (context, state) {});
    });
  }

  Widget card(context, PostModel model, index) => Column(
        children: [
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(model.image),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(height: 1.2),
                          ),
                          Text(
                            model.dateTime,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(height: 1.2),
                          )
                        ],
                      )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Iconsax.edit_24,
                            size: 18,
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  Row(
                    children: [
                      Text(model.text),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  // Container(
                  //   width: double.infinity,
                  //   child: Wrap(
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsetsDirectional.only(end: 3.0),
                  //         child: InkWell(
                  //           child: Text(
                  //             "#AlAhly",
                  //             style: TextStyle(color: Colors.blue),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  if (model.postPhoto.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4)),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(model.postPhoto),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      InkWell(
                          // onPressed: () {},
                          child: const Icon(
                        Iconsax.heart,
                        color: Colors.red,
                        size: 19,
                      )),
                      const SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        child: Text(
                          "${LayoutCubit.get(context).likes[index]}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.grey[300]),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                          // onPressed: () {},
                          child: const Icon(
                        Iconsax.message,
                        color: Color.fromARGB(255, 247, 222, 2),
                        size: 19,
                      )),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        child: Text(
                          "${LayoutCubit.get(context).numberOfComments[index]}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.grey[300]),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            LayoutCubit.get(context).getModel!.image),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          defaultnavigator(
                              context,
                              Comment(
                                id: LayoutCubit.get(context).ids[index],
                              ));
                        },
                        child: Text(
                          "Write a comment...",
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 14),
                        ),
                      )),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                LayoutCubit.get(context).likePosts(
                                    id: LayoutCubit.get(context).ids[index]);
                              },
                              child: const Icon(
                                Iconsax.heart,
                                color: Colors.red,
                                size: 19,
                              )),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Like",
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          )
        ],
      );
}
