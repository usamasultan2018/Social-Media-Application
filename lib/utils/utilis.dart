import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{
  static void fieldFocus(BuildContext context,FocusNode currentNode,FocusNode nextFocus){
   currentNode.unfocus();
   FocusScope.of(context).requestFocus(nextFocus);
  }
  static toastMessage(String msg){
    Fluttertoast.showToast(msg: msg,
    backgroundColor: Color(0xff000000),
      textColor:Color(0xffffffff),
      fontSize: 16,
    );
  }
}