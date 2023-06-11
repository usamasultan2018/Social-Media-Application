import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;

  const MyTextBox(
      {Key? key,
      required this.text,
      required this.sectionName,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
              IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.settings,
                    color: Colors.grey.shade500,
                  ))
            ],
          ),
          Text(text),
        ],
      ),
    );
  }
}
