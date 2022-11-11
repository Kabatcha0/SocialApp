import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/models/chatdetail.dart';
import 'package:socialapp/models/chatmodel.dart';
import 'package:socialapp/models/firestoreregister.dart';
import 'package:socialapp/shared/const/constant.dart';

class MessageDetails extends StatelessWidget {
  TextEditingController writeController = TextEditingController();
  ChatModel model;
  MessageDetails({required this.model});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      LayoutCubit.get(context).getMessages(reciveId: model.uid);
      return BlocConsumer<LayoutCubit, LayoutStates>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 1,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(model.profileImage),
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
                          .copyWith(color: primary),
                    ),
                  ],
                )),
              ],
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Iconsax.call)),
              IconButton(onPressed: () {}, icon: const Icon(Iconsax.video))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is UploadChatImageLoading)
                  const LinearProgressIndicator(),
                Expanded(
                    child: ConditionalBuilder(
                  builder: (context) => ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (uiD ==
                            LayoutCubit.get(context).messages[index].senderId)
                          return mySend(
                            LayoutCubit.get(context).messages[index],
                            LayoutCubit.get(context).getModel!,
                          );
                        return friendSend(
                            LayoutCubit.get(context).messages[index]);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: LayoutCubit.get(context).messages.length),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  condition: LayoutCubit.get(context).messages.isNotEmpty,
                )),
                Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        border: Border.all(color: primary, width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 8.0),
                            child: TextFormField(
                              controller: writeController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "write what you want tell him ...",
                                  hintStyle: TextStyle(color: primary)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              color: primary,
                              child: IconButton(
                                  onPressed: () {
                                    LayoutCubit.get(context).chatImagePicker();
                                  },
                                  icon: const Icon(
                                    Iconsax.gallery_add,
                                    color: Colors.white,
                                  ))),
                        ),
                        // const SizedBox(
                        //   width: 5,
                        // ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              color: primary,
                              child: IconButton(
                                  onPressed: () {
                                    if (writeController.text.isNotEmpty ||
                                        LayoutCubit.get(context).chatImage !=
                                            null) {
                                      if (LayoutCubit.get(context).chatImage ==
                                          null) {
                                        LayoutCubit.get(context).sendChat(
                                            dateTime: DateTime.now().toString(),
                                            reciveId: model.uid,
                                            text: writeController.text);
                                      } else {
                                        LayoutCubit.get(context)
                                            .uploadChatImage(
                                                dateTime:
                                                    DateTime.now().toString(),
                                                reciveId: model.uid,
                                                text: writeController.text);
                                      }
                                    }
                                  },
                                  icon: const Icon(
                                    Iconsax.send,
                                    color: Colors.white,
                                  ))),
                        )
                      ],
                    )),
                if (LayoutCubit.get(context).chatImage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          width: double.infinity,
                          height: 220,
                          child: Image(
                              fit: BoxFit.cover,
                              image: FileImage(
                                  LayoutCubit.get(context).chatImage!)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(4)),
                            child: InkWell(
                              onTap: () {
                                LayoutCubit.get(context).chatImageRemove();
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is SendChatSuccess) {
          writeController.text = "";
          LayoutCubit.get(context).chatImageRemove();
        }
      });
    });
  }

  Widget mySend(ChatDetails model, FireStoreRegister myModel) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              myModel.name,
              style: const TextStyle(
                  height: 1.2,
                  fontSize: 10,
                  color: Color.fromARGB(255, 25, 13, 131)),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              width: 135,
              height: 35,
              decoration: const BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(4),
                      topEnd: Radius.circular(4),
                      topStart: Radius.circular(4))),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(model.text,
                    style: const TextStyle(fontSize: 13, color: Colors.white)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (model.image.isNotEmpty)
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                width: double.infinity,
                height: 200,
                child: Image(
                  image: NetworkImage(model.image),
                  fit: BoxFit.cover,
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget friendSend(ChatDetails model) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name,
              style: const TextStyle(
                  fontSize: 10, color: Color.fromARGB(255, 25, 13, 131)),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              width: 135,
              height: 35,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 25, 13, 131),
                  borderRadius: BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(4),
                      topEnd: Radius.circular(4),
                      topStart: Radius.circular(4))),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(model.name,
                    style: const TextStyle(fontSize: 13, color: Colors.white)),
              ),
            ),
            if (model.image.isNotEmpty)
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                width: double.infinity,
                height: 200,
                child: Image(
                  image: NetworkImage(model.image),
                  fit: BoxFit.cover,
                ),
              )
          ],
        ),
      ),
    );
  }
}
