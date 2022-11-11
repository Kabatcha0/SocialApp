import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:socialapp/conponent/components.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/layout/layout.dart';
import 'package:socialapp/models/commentmodel.dart';
import 'package:socialapp/shared/const/constant.dart';

class Comment extends StatelessWidget {
  TextEditingController sheetControl = TextEditingController();
  GlobalKey<FormState> keyState = GlobalKey<FormState>();
  String id;
  Comment({required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()
        ..getComments(id: id)
        ..getData(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {
          if (state is CreateCommentSucess) {
            LayoutCubit.get(context).imageCommentRemove();
            sheetControl.text = "";
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    defaultnavigatorRemove(context, SocialLayout());
                  },
                  icon: const Icon(
                    Iconsax.arrow_left,
                    color: primary,
                  )),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: keyState,
                child: Column(
                  children: [
                    if (state is UploadCommentImageLoading)
                      const LinearProgressIndicator(),
                    if (state is UploadCommentImageLoading)
                      const SizedBox(
                        height: 10,
                      ),
                    Expanded(
                      child: ConditionalBuilder(
                          condition:
                              LayoutCubit.get(context).comments.isNotEmpty,
                          builder: (context) {
                            return ListView.separated(
                                itemBuilder: (context, index) => showTheComment(
                                    context,
                                    LayoutCubit.get(context).comments[index]),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 10,
                                    ),
                                itemCount:
                                    LayoutCubit.get(context).comments.length);
                          },
                          fallback: (context) => const Center(
                                child: CircularProgressIndicator(),
                              )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "                   please write the comment";
                                  }
                                  return null;
                                },
                                controller: sheetControl,
                                decoration: const InputDecoration(
                                    hintText: "Write a comment",
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Iconsax.pen_add,
                                      color: primary,
                                    )),
                              )),
                              const SizedBox(
                                width: 5,
                              ),
                              IconButton(
                                  onPressed: () {
                                    LayoutCubit.get(context)
                                        .commentImagePicker();
                                  },
                                  icon: const Icon(
                                    Iconsax.gallery,
                                    color: primary,
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (keyState.currentState!.validate()) {
                                      if (LayoutCubit.get(context)
                                              .commentImage !=
                                          null) {
                                        LayoutCubit.get(context)
                                            .uploadCommentImage(
                                                text: sheetControl.text,
                                                dateTime:
                                                    DateTime.now().toString(),
                                                id: id);
                                      } else {
                                        LayoutCubit.get(context).createComment(
                                            text: sheetControl.text,
                                            dateTime: DateTime.now().toString(),
                                            id: id);
                                      }
                                    }
                                  },
                                  icon: const Icon(
                                    Iconsax.send,
                                    color: primary,
                                  ))
                            ],
                          ),
                          if (LayoutCubit.get(context).commentImage != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: FileImage(LayoutCubit.get(context)
                                          .commentImage!),
                                      width: double.infinity,
                                      height: 300,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        LayoutCubit.get(context)
                                            .imageCommentRemove();
                                      },
                                      icon: Container(
                                        decoration: BoxDecoration(
                                            color: primary,
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ))
                                ],
                              ),
                            )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget showTheComment(context, CommentModel model) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
                radius: 30, backgroundImage: NetworkImage(model.image)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
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
                    model.text,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(height: 1.2),
                  ),
                  if (model.commentImage != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(model.commentImage!),
                          width: double.infinity,
                          height: 300,
                        ),
                      ),
                    )
                ],
              ),
            )),
          ],
        ),
      ],
    );
  }
}
