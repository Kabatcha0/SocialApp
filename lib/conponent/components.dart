import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/shared/const/constant.dart';

void defaultnavigatorRemove(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

void defaultnavigator(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget defaultTextButton(
        {required Function() function,
        required String text,
        required BuildContext context}) =>
    TextButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style:
              Theme.of(context).textTheme.bodyText2?.copyWith(color: primary),
        ));
Widget defaultTextFormField(
        {required IconData icon,
        IconData? sicon,
        required String text,
        String? Function(String?)? function,
        required TextEditingController control,
        bool obscure = false,
        TextInputType? type,
        Function()? suffixpressed,
        Function(String)? change,
        bool isSuffix = true}) =>
    TextFormField(
      onChanged: change,
      obscureText: obscure,
      keyboardType: type,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: text,
        prefixIcon: Icon(icon),
        suffixIcon: isSuffix
            ? IconButton(icon: Icon(sicon), onPressed: suffixpressed)
            : null,
        enabledBorder: const OutlineInputBorder(),
      ),
      validator: function,
      controller: control,
      cursorColor: primary,
    );
Widget defaultbutton({
  required Function() function,
  required String text,
}) =>
    SizedBox(
      width: double.infinity,
      height: 50,
      child: MaterialButton(
        splashColor: Colors.transparent,
        onPressed: function,
        color: primary,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

void changeColor({required String msg, required ToastState state}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: color(state),
    textColor: Colors.white,
    fontSize: 16,
    timeInSecForIosWeb: 1,
  );
}

enum ToastState { warning, error }

Color color(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.warning:
      color = Colors.yellow;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
  }
  return color;
}
