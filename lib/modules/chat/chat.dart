import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/conponent/components.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/models/chatmodel.dart';
import 'package:socialapp/modules/messagedetails/messagedetail.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: LayoutCubit.get(context).usersChat.isNotEmpty,
            builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => getUsersChat(
                    context, LayoutCubit.get(context).usersChat[index]),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                itemCount: LayoutCubit.get(context).usersChat.length),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget getUsersChat(context, ChatModel model) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          defaultnavigator(
              context,
              MessageDetails(
                model: model,
              ));
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
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
                      .copyWith(height: 1.2),
                ),
                // Text(
                //   "please give me a one million dollars",
                //   style: Theme.of(context)
                //       .textTheme
                //       .caption!
                //       .copyWith(height: 1.2),
                // )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
