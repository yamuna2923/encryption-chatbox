import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:encryptionChatBox/data/keys/keys.dart';
import 'package:encryptionChatBox/data/userData/userData.dart';
import 'package:encryptionChatBox/logic/auth/authLogic.dart';
import 'package:encryptionChatBox/ui-components/ui/buttons/buttons.dart';
import 'package:encryptionChatBox/views/app/chat/const.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic> keys;

  onLoadAc()async{
    keys = await MyRSA().generateKeys();
  } 

  @override
  void initState() {
    onLoadAc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                      child: universalUserData.userData.data()['profileImage'] == null ? Icon(
                        Icons.account_circle,
                        size: 60.0,
                        color: greyColor,
                      ) : CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(themeColor),
                          ),
                          width: 40.0,
                          height: 40.0,
                          padding: EdgeInsets.all(15.0),
                        ),
                        imageUrl: universalUserData.userData.data()['profileImage'],
                        width: 60.0,
                        height: 60.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(universalUserData.userData.data()['name'], style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text("Username : "+universalUserData.userData.data()['username'], style: TextStyle(
                          
                        ),),
                      ],
                    ),
                  )
                ],
              ),
            ), 
            SizedBox(
              height: 10.0,
            ),
            ListTile(
              title: Text("User Id"),
              subtitle: Text(universalUserData.userData.data()['uid']),
            ),
            ListTile(
              title: Text("Email"),
              subtitle: Text(universalUserData.userData.data()['emailId']),
            ),
            ListTile(
              title: Text("Address (Based on your IP Address)"),
              subtitle: Text(universalUserData.userData.data()['city']+", "+universalUserData.userData.data()['state']+", "+universalUserData.userData.data()['country']+" - "+universalUserData.userData.data()['pincode']),
            ),
            ListTile(
              title: Text("Push Token"),
              subtitle: Text(universalUserData.userData.data()['pushToken'].toString()),
            ),
            CustomButton().normalButton("Signout", ()async{
              AuthLogic().signOutUser(context);
            }),
          ],
        )
      ),
    );
  }
}