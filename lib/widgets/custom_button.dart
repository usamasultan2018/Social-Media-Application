import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;

  final String title;
  final bool? loading;

  const CustomButton({Key? key, this.onTap, required this.title, this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child:loading!?CircularProgressIndicator(color: Colors.white,): Text(
            title,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
