import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/conponent/components.dart';
import 'package:socialapp/layout/cubit/states.dart';
import 'package:socialapp/models/chatdetail.dart';
import 'package:socialapp/models/chatmodel.dart';
import 'package:socialapp/models/commentmodel.dart';
import 'package:socialapp/models/firestoreregister.dart';
import 'package:socialapp/models/postmodel.dart';
import 'package:socialapp/modules/chat/chat.dart';
import 'package:socialapp/modules/home/home.dart';
import 'package:socialapp/modules/post/post.dart';
import 'package:socialapp/modules/settings/settings.dart';
import 'package:socialapp/modules/users/users.dart';
import 'package:socialapp/shared/const/constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(InitialLayout());
  static LayoutCubit get(context) => BlocProvider.of(context);
  List<String> title = ["News Feeds", "Chat", "", "Users", "Settings"];
  List<Widget> changeScreen = [Home(), Chat(), Post(), Users(), Setting()];
  int currentIndex = 0;
  void onTap(int index, context) {
    if (index == 1) getChat();
    if (index == 2) {
      defaultnavigator(context, Post());
      emit(PostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavigator());
    }
  }

  FireStoreRegister? getModel;
  void getData() {
    FirebaseFirestore.instance.collection("users").doc(uiD).get().then((value) {
      getModel = FireStoreRegister.fromjson(value.data()!);
      emit(SucessLayout());
    }).catchError((onError) {
      emit(ErrorLayout(error: onError));
    });
  }

// upload profile & cover photo
  File? profileImage;
  var picker = ImagePicker();
  Future profileImagePicker() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      profileImage = File(PickedFile.path);
      emit(ProfileImageSucess());
    } else {
      print("no image selected");
      emit(ProfileImageError());
    }
  }

  File? coverImage;
  var pickerCover = ImagePicker();
  Future coverImagePicker() async {
    final PickedFile = await pickerCover.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      coverImage = File(PickedFile.path);
      emit(CoverImageSucess());
    } else {
      print("no image selected");
      emit(CoverImageError());
    }
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UploadCoverLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        update(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((onError) {
        emit(CovereUrlError());
      });
    }).catchError((onError) {
      emit(CoverePutError());
    });
  }

  void uploadprofileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UploadProfileLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        update(name: name, phone: phone, bio: bio, image: value);
      }).catchError((onError) {
        emit(ProfileUrlError());
      });
    }).catchError((onError) {
      emit(ProfilePutError());
    });
  }

  void update(
      {required String name,
      required String phone,
      required String bio,
      String? image,
      String? cover}) {
    print(image);
    print(cover);
    FireStoreRegister model = FireStoreRegister(
        email: getModel!.email,
        name: name,
        password: getModel!.password,
        phone: phone,
        uid: getModel!.uid,
        bio: bio,
        cover: cover ?? getModel!.cover,
        image: image ?? getModel!.image);

    FirebaseFirestore.instance
        .collection("users")
        .doc(uiD)
        .update(model.toMap())
        .then((value) {
      getData();
    }).catchError((onError) {
      emit(UpdateError());
    });
  }

  // upload & create posts
  File? postImage;
  var postPicker = ImagePicker();
  Future postImagePicker() async {
    final pickedFile = await postPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImageSucess());
    } else {
      print("no image selected");
      emit(PostImageError());
    }
  }

  void uploadpostImage({required String text, required String dateTime}) {
    emit(UploadpostImageLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createpost(text: text, dateTime: dateTime, postPhoto: value);
      }).catchError((onError) {});
    }).catchError((onError) {});
  }

  void createpost(
      {required String text, String? postPhoto, required String dateTime}) {
    emit(CreatepostLoading());
    PostModel model = PostModel(
        postPhoto: postPhoto ?? "",
        name: getModel!.name,
        uid: getModel!.uid,
        dateTime: dateTime,
        image: getModel!.image,
        text: text);

    FirebaseFirestore.instance
        .collection("posts")
        .add(model.toMap())
        .then((value) {
      emit(CreatepostSucess());
    }).catchError((onError) {
      emit(CreatepostError());
    });
  }

  // remove postImage
  void removePostImage() {
    postImage = null;
    emit(RemovePostImageSucess());
  }

  // get Post
  List<PostModel> posts = [];
  List<String> ids = [];
  List<int> numberOfComments = [];
  void getPosts() {
    emit(GetPostsLoading());
    FirebaseFirestore.instance
        .collection("posts")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      posts = [];
      event.docs.forEach((element) {
        element.reference.collection("comment").get().then((val) {
          numberOfComments.add(val.docs.length);
        });
        element.reference.collection("Likes").get().then((value) {
          likes.add(value.docs.length);
          ids.add(element.id);
          posts.add(PostModel.fromjson(element.data()));
        });
        emit(GetPostsSuccess());
      });
    });
  }

  // like Post
  List<int> likes = [];
  void likePosts({required String id}) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .collection("Likes")
        .doc(getModel!.uid)
        .set({"like": true}).then((value) {
      emit(LikesPostsSuccess());
    }).catchError((onError) {
      emit(LikesPostsError());
    });
  }

  // get user //chat
  List<ChatModel> usersChat = [];
  void getChat() {
    if (usersChat.isEmpty) {
      FirebaseFirestore.instance.collection("users").get().then((value) {
        value.docs.forEach((element) {
          if (element.data()["uid"] != uiD)
            usersChat.add(ChatModel.fromjson(element.data()));
          emit(GetUsersChatsSuccess());
        });
      }).catchError((onError) {
        emit(GetUsersChatsError());
      });
    }
  }

  // upload photo comment
  File? commentImage;
  var commentPicker = ImagePicker();
  Future commentImagePicker() async {
    final pickedFile =
        await commentPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      commentImage = File(pickedFile.path);
      emit(CommentImageSucess());
    } else {
      print("no image selected");
      emit(CommentImageError());
    }
  }

  // remove image comment
  void imageCommentRemove() {
    commentImage = null;
    emit(RemoveCommentImageSucess());
  }

  // upload and create comment
  void uploadCommentImage(
      {required String text, required String dateTime, required String id}) {
    emit(UploadCommentImageLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(commentImage!.path).pathSegments.last}")
        .putFile(commentImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createComment(
            text: text, dateTime: dateTime, id: id, commentPhoto: value);
      }).catchError((onError) {});
    }).catchError((onError) {});
  }

  void createComment({
    required String text,
    String? commentPhoto,
    required String dateTime,
    required String id,
  }) {
    emit(CreateCommentLoading());
    CommentModel model = CommentModel(
        name: getModel!.name,
        date: dateTime,
        text: text,
        commentImage: commentPhoto,
        image: getModel!.image);

    FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .collection("comment")
        .add(model.toMap())
        .then((value) {
      emit(CreateCommentSucess());
    }).catchError((onError) {
      emit(CreateCommentError());
    });
  }

  //get comments
  List<CommentModel> comments = [];
  void getComments({required String id}) {
    comments = [];
    emit(GetCommentsLoading());
    FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .collection("comment")
        .orderBy("date")
        .snapshots()
        .listen((event) {
      comments = [];
      event.docs.forEach((element) {
        comments.add(CommentModel.fromjson(element.data()));
        emit(GetCommentsSuccess());
      });
    });
  }

  //upload chat image
  void uploadChatImage({
    required String dateTime,
    required String reciveId,
    required String text,
  }) {
    emit(UploadChatImageLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("chats/${Uri.file(chatImage!.path).pathSegments.last}")
        .putFile(chatImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendChat(
            dateTime: dateTime, reciveId: reciveId, text: text, image: value);
      }).catchError((onError) {
        emit(UploadChatImageError());
      });
    }).catchError((onError) {
      emit(UploadChatImageError());
    });
  }

  // send chat
  void sendChat(
      {required String dateTime,
      required String reciveId,
      required String text,
      String? image}) {
    ChatDetails model = ChatDetails(
        name: getModel!.name,
        date: dateTime,
        text: text,
        image: image ?? "",
        senderId: uiD!,
        reciveId: reciveId);
    FirebaseFirestore.instance
        .collection("users")
        .doc(uiD)
        .collection("chat")
        .doc(reciveId)
        .collection("message")
        .add(model.toMap())
        .then((value) {
      emit(SendChatSuccess());
    }).catchError((onError) {
      emit(SendChatError());
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(reciveId)
        .collection("chat")
        .doc(uiD)
        .collection("message")
        .add(model.toMap())
        .then((value) {
      emit(SendChatSuccess());
    }).catchError((onError) {
      emit(SendChatError());
    });
  }

  // get chat
  List<ChatDetails> messages = [];
  void getMessages({required String reciveId}) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uiD)
        .collection("chat")
        .doc(reciveId)
        .collection("message")
        .orderBy("date")
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(ChatDetails.fromjson(element.data()));
      });
      emit(GetChatData());
    });
  }

  File? chatImage;
  var pickerChat = ImagePicker();
  Future chatImagePicker() async {
    final PickedFile = await pickerChat.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      chatImage = File(PickedFile.path);
      emit(ChatImageSucess());
    } else {
      print("no image selected");
      emit(ChatImageError());
    }
  }

  void chatImageRemove() {
    chatImage = null;
    emit(ChatImageRemoveState());
  }
}
