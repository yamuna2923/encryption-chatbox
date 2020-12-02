import 'package:encryptionChatBox/views/app/chat/const.dart';
import 'package:flutter/material.dart';

class CustomButton{
  Widget primaryButton(String title, Function onPressed){
    return MaterialButton(
      enableFeedback: true,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      padding: EdgeInsets.only(top: 12, bottom: 12),
      color: primaryColor,
      onPressed: (){
        onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(title, style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontFamily: "KumbhSans Bold"
          ),),
        ],
      )
    );
  }


  Widget normalButton(String title, Function onPressed){
    return RaisedButton(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),
      color: primaryColor,
      onPressed: (){
        onPressed();
      },
      child: Text(title, style: TextStyle(
        color: Colors.white,
        fontFamily: "KumbhSans"
      ),),
    );
  }
}