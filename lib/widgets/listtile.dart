import 'package:flutter/material.dart';
class MyListTile extends StatelessWidget {
  final IconData icon;
  final String title;
 final Function()? onTap;
  const MyListTile({Key? key, required this.icon, required this.title,required  this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon,color: Colors.white,),
        title: Text(title,style: const TextStyle(color: Colors.white),),

      ),
    );
  }
}
