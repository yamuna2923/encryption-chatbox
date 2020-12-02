import 'package:encryptionChatBox/ui-components/ui/buttons/buttons.dart';
import 'package:encryptionChatBox/views/app/chat/const.dart';
import 'package:flutter/material.dart';

class CustomAlert{
  buildAlert(BuildContext context, String title, String subTitle){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text(title, style: TextStyle(
            color: primaryColor
          ),),
          content: Text(subTitle, style: TextStyle(
            color: Colors.black
          ),),
          actions: [
            CustomButton().normalButton("Okay", (){
              Navigator.pop(context);
            })
          ],
        );
      }
    );
  }

  void openLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Wrap(
            children: [
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          )
        );
      },
    );
  }
}