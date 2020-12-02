import 'dart:ui';
import 'package:encryptionChatBox/data/userData/userData.dart';
import 'package:encryptionChatBox/views/app/chat/homeScreen.dart';
import 'package:encryptionChatBox/views/app/profile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selIndex = 0;

  List<Widget> tabs = [
    HomeScreen(currentUserId: universalUserData.userData.id,),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("./assets/images/encChatBox.png", width: 40.0,),
              SizedBox(
                width: 10.0
              ),
              Text("Encryption Chat Box", style: TextStyle(
                fontFamily: "KumbhSans Bold",
                fontSize: 17.0
              ),)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int i){
          setState(() {
            selIndex = i;
          });
        },
        currentIndex: selIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile"
          )
        ],
      ),
      body: tabs[selIndex],
    );
  }
}
