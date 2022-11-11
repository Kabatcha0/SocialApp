import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/conponent/components.dart';
import 'package:socialapp/layout/cubit/cubit.dart';
import 'package:socialapp/layout/layout.dart';
import 'package:socialapp/modules/login/login.dart';
import 'package:socialapp/shared/const/constant.dart';
import 'package:socialapp/shared/network/local/cachehelper.dart';
import 'package:socialapp/shared/style/themes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage msg) async {
  print(msg.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget wid;
  await CacheHelper.init();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print("the token is : $token");
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  uiD = CacheHelper.getData(key: "UID");
  if (uiD != null) {
    wid = SocialLayout();
  } else {
    wid = Login();
  }
  runApp(MyApp(
    start: wid,
  ));
}

class MyApp extends StatelessWidget {
  final Widget start;
  MyApp({super.key, required this.start});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LayoutCubit()
              ..getData()
              ..getPosts())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        themeMode: mode ? ThemeMode.light : ThemeMode.dark,
        darkTheme: darkTheme,
        home: start,
      ),
    );
  }
}
