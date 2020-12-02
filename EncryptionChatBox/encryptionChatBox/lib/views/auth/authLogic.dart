import 'package:encryptionChatBox/logic/auth/authLogic.dart';
import 'package:encryptionChatBox/views/app/chat/const.dart';
import 'package:encryptionChatBox/views/auth/emailAuth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                
                Container(
                  padding: EdgeInsets.all(20.0),
                  height: MediaQuery.of(context).size.height*0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("./assets/images/encChatBox.png", width: 200.0,),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text("Encryption Chat Box", style: TextStyle(
                        fontFamily: "KumbhSans Bold",
                        color: Colors.white
                      ),)
                    ],
                  )
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      RaisedButton(
                        padding: EdgeInsets.all(12.0),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)
                        ),
                        onPressed: ()async{
                          AuthLogic().signInWithGoogle(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Icon(FontAwesomeIcons.google, size: 20.0, color: Colors.black,),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text("Continue with Google", style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "KumbhSans"
                            ),)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        padding: EdgeInsets.all(12.0),
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)
                        ),
                        onPressed: ()async{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> EmailAndPasswordSignIn()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.email, size: 20.0, color: Colors.white,),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text("Continue with Email", style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontFamily: "KumbhSans"
                            ),)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Text("By proceeding you agree to our terms of service and privacy policy", style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0
                        ), textAlign: TextAlign.center,),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}