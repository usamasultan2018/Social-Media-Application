import 'package:flutter/material.dart';
class CustomCommentButton extends StatelessWidget {
  final void Function()? onTap;
  const CustomCommentButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: const Icon(Icons.comment,color: Colors.grey,),
    );
  }
}
