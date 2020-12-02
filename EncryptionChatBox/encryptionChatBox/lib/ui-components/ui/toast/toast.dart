import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ShowToast{
  
  showToast(BuildContext context, String val) async{
    Toast.show("$val", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,);
  }
}