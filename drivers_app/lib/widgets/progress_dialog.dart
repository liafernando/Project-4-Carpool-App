import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget
{
  String? message;
  ProgressDialog({this.message});


  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black54,
      child: Container(
        margin: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Row(
            children: [
              const SizedBox(width: 2.0,),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              const SizedBox(width: 26.0,),

              Text(
                message!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
