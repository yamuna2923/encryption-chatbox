import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encryptionChatBox/data/userData/userData.dart';
import 'package:encryptionChatBox/logic/getLocation/getLocationInfo.dart';
import 'package:encryptionChatBox/main.dart';
import 'package:encryptionChatBox/ui-components/settings/updateUsername.dart';
import 'package:encryptionChatBox/ui-components/ui/alert/alertBox.dart';
import 'package:encryptionChatBox/views/app/mainHomePage.dart';
import 'package:encryptionChatBox/views/auth/introPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ip_geolocation_api/ip_geolocation_api.dart';

class AuthLogic{

  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid ? 'com.dfa.flutterchatdemo' : 'com.duytq.flutterchatdemo',
      'Flutter chat demo',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics =
        new NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    print(message);
//    print(message['body'].toString());
//    print(json.encode(message));

    await flutterLocalNotificationsPlugin.show(
        0, message['title'].toString(), message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));

//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', 'plain body', platformChannelSpecifics,
//        payload: 'item x');
  }

  initAuth(BuildContext context){
    User user = FirebaseAuth.instance.currentUser;
    if(user != null){
      userDataVerification(context, user);
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> IntroPage()));
    }
  }

  signInWithGoogle(BuildContext context)async{
    UserCredential user;
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final googleAuth = await googleSignInAccount.authentication;
      final googleAuthCred = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, 
        accessToken: googleAuth.accessToken
      );
      user = await FirebaseAuth.instance.signInWithCredential(googleAuthCred);
      await userDataVerification(context, user.user);
    } catch (error) {
      print(error);
      return 0;
    }
  }

  signInWithEmailId(BuildContext context, String email, String password)async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password
    ).then((UserCredential userCredential)async{
      await userDataVerification(context, userCredential.user);
    }).catchError((e){
      print(e);
      CustomAlert().buildAlert(context, "Error", e.message);
    });
  }

  signUpWithEmailIdAndPassword(BuildContext context, String name, String email, String password)async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password
    ).then((UserCredential userCredential)async{
      await FirebaseAuth.instance.currentUser.updateProfile(
        displayName: name,
        photoURL: null
      );
      await FirebaseAuth.instance.currentUser.reload();
      await userDataVerification(context, FirebaseAuth.instance.currentUser);
    }).catchError((e){
      print(e);
      CustomAlert().buildAlert(context, "Error", e.message);
    });
  }

  userDataVerification(BuildContext context, User user)async{

    await FirebaseFirestore.instance.collection("users").doc(user.uid).get().then((DocumentSnapshot docSnap)async{
      if(docSnap.data() != null){
        universalUserData.userData = docSnap;
        if(docSnap.data()['username'] == null || docSnap.data()['username'].trim() == ""){
          bool usernameRes = false;
          await Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateUsername(isUpdated: (val){
            if(val){
              usernameRes = true;
            }
          },)));
          if(usernameRes){
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SplashScreen()),
                (Route<dynamic> route) => false);
          }
        }else{
          FirebaseMessaging firebaseMessaging = FirebaseMessaging();
          String fcmToken = await firebaseMessaging.getToken();
          FirebaseFirestore.instance.collection("users").doc(universalUserData.userData.id).update({
            "fcmToken": FieldValue.arrayUnion([fcmToken]),
            "lastUsed": Timestamp.now()
          }).catchError((e){
            print(e);
          });
          Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePage()),
                (Route<dynamic> route) => false);
        }
      }else{
        GeolocationData geolocationData = await GeolocationAPI.getData();
        LocData locData = await GetLocation().fetchLocFromLatAndLong(geolocationData.lat, geolocationData.lon);
        FirebaseMessaging firebaseMessaging = FirebaseMessaging();
        String fcmToken = await firebaseMessaging.getToken();
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "name": user.displayName,
          "username": null,
          "profileImage": user.photoURL,
          "dateOfBirth": null,
          "emailId": user.email,
          "phoneNumber": user.phoneNumber,
          "city": locData.address[0].locality,
          "district": locData.address[0].subAdministrativeArea,
          "state": locData.address[0].administrativeArea,
          "country": geolocationData.country,
          "countryCode": geolocationData.countryCode,
          "currencyCountryCode": geolocationData.countryCode,
          "pincode": locData.address[0].postalCode,
          
          "joinedOn": Timestamp.now(),
          "lastUsed": Timestamp.now(),

          "fcmToken": FieldValue.arrayUnion([fcmToken])
        }).then((E){
          userDataVerification(context, user);
        }).catchError((e){
          print(e);
        });
      }
    }).catchError((e){  
      print(e);
      CustomAlert().buildAlert(context, "Error", e?.message.toString());
    });

    
  }


  signOutUser(BuildContext context)async{
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    String fcmToken = await firebaseMessaging.getToken();
    await FirebaseFirestore.instance.collection("users").doc(universalUserData.userData.id).update({
      "fcmToken": FieldValue.arrayRemove([fcmToken]),
    }).then((E){
      FirebaseAuth.instance.signOut();
      GoogleSignIn().signOut();
      universalUserData.userData = null;
      Navigator.of(context).pushAndRemoveUntil (
                MaterialPageRoute(builder: (context) => SplashScreen()),
                (Route<dynamic> route) => false);
    }).catchError((e){
      print(e);
      CustomAlert().buildAlert(context, "Error", e.message);
    });
  }



}
