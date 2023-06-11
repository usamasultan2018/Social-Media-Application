import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  final String text;
  final String user;
  final String time;

  const Comments(
      {Key? key,
        required this.text,
        required this.user,
        required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(4),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Comment
          Text(text),
          SizedBox(height: 5,),
          //user & time
         Row(
           children: [
             Text(user,style: TextStyle(color: Colors.grey.shade400),),
             Text(" * ",style: TextStyle(color: Colors.grey.shade400)),
             Text(time,style: TextStyle(color: Colors.grey.shade400)),
           ],
         )
        ],
      ),
    );
  }
}
