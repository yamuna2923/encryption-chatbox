import 'package:encryptionChatBox/views/auth/authLogic.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  List<Slide> slides = new List();

 @override
 void initState() {
   super.initState();
   slides.add(
     new Slide(
       backgroundColor: Colors.green,
       title: "Let's Grow together",
       description:
       "Get Started & Let's Start Growing together",
       pathImage: "assets/images/encChatBox.png",
     ),
   );
   slides.add(
     new Slide(
       backgroundColor: Colors.green,
       title: "Promote",
       description: "Spade Market will help your Content to promote to more audiance and help you start growing.",
       pathImage: "assets/images/encChatBox.png",
     ),
   );
   slides.add(
     new Slide(
       backgroundColor: Colors.green,
       title: "Community",
       description: "Build your Community with Spade Market!\nGet Started",
       pathImage: "assets/images/encChatBox.png",
     ),
   );
   
 }

 void onDonePress() async{
   Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthPage()));
 }

 @override
 Widget build(BuildContext context) {
   return Scaffold(
       body: IntroSlider(
        slides: this.slides,
        onDonePress: this.onDonePress,
      ),
     );
 }
}