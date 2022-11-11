import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/conponent/components.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/layout/layout.dart';
import 'package:socialapp/shared/const/constant.dart';

class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        TextEditingController textController = TextEditingController();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Create Post",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: primary),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                defaultnavigatorRemove(context, SocialLayout());
              },
            ),
            actions: [
              defaultTextButton(
                  function: () {
                    if (LayoutCubit.get(context).postImage != null) {
                      LayoutCubit.get(context).uploadpostImage(
                          text: textController.text,
                          dateTime: DateTime.now().toString());
                      LayoutCubit.get(context).removePostImage();
                    } else {
                      LayoutCubit.get(context).createpost(
                          text: textController.text,
                          dateTime: DateTime.now().toString());
                    }
                  },
                  text: "Post",
                  context: context)
            ],
          ),
          body: Column(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if (state is CreatepostLoading &&
                          state is UploadpostImageLoading)
                        const LinearProgressIndicator(),
                      if (state is CreatepostLoading &&
                          state is UploadpostImageLoading)
                        const SizedBox(height: 15),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                LayoutCubit.get(context).getModel!.image),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Mohamed Mostafa",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(height: 1.2),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                          hintText: "write what you want ...",
                          border: InputBorder.none),
                    ),
                  )),
              if (LayoutCubit.get(context).postImage != null)
                const SizedBox(
                  height: 20,
                ),
              if (LayoutCubit.get(context).postImage != null)
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image(
                          fit: BoxFit.cover,
                          image: FileImage(LayoutCubit.get(context).postImage!),
                        ),
                        IconButton(
                            iconSize: 30,
                            color: primary,
                            onPressed: () {
                              LayoutCubit.get(context).removePostImage();
                            },
                            icon: const Icon(Iconsax.close_circle))
                      ],
                    ),
                  ),
                ),
              if (LayoutCubit.get(context).postImage != null)
                const SizedBox(
                  height: 5,
                ),
              // const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    Expanded(
                        child: defaultTextButton(
                            function: () {
                              LayoutCubit.get(context).postImagePicker();
                            },
                            text: "add photo",
                            context: context)),
                    Expanded(
                        child: defaultTextButton(
                            function: () {}, text: "# tags", context: context))
                  ],
                ),
              )
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
