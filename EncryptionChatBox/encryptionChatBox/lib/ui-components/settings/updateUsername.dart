import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encryptionChatBox/data/userData/userData.dart';
import 'package:encryptionChatBox/ui-components/ui/alert/alertBox.dart';
import 'package:encryptionChatBox/ui-components/ui/forms/textInputDecoration.dart';
import 'package:flutter/material.dart';

class UpdateUsername extends StatefulWidget {
  final ValueChanged<bool> isUpdated;
  UpdateUsername({@required this.isUpdated}); 
  @override
  _UpdateUsernameState createState() => _UpdateUsernameState();
}

class _UpdateUsernameState extends State<UpdateUsername> {
  bool isLoading = false;
  bool isAvailiable;
  TextEditingController textEditingController = TextEditingController();

  checkAvailiabilityAndUpdate()async{
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance.collection("users").where("username", isEqualTo: textEditingController.text).get().then((QuerySnapshot qSnapData)async{
      if(qSnapData.docs.length == 0){
        isAvailiable = true;
        await FirebaseFirestore.instance.collection("users").doc(universalUserData.userData.id).update({
          "username": textEditingController.text
        }) .then((res){
          widget.isUpdated(true);
          Navigator.pop(context);
        }).catchError((e){
          print(e);
          CustomAlert().buildAlert(context, "Error", e.message.toString());
        });
        widget.isUpdated(true);
        Navigator.pop(context);
      }else{
        isAvailiable = false;
      }
    }).catchError((e){
      print(e);
      CustomAlert().buildAlert(context, "Error", e.message);
    });
    
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set a username"),
        actions: [
          isLoading ? Center(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  backgroundColor: Colors.black,
                ),
                  height: 25.0,
                  width: 25.0,
              ),
            )
          ) : IconButton(
            onPressed: (){
              if(textEditingController.text.trim().length >= 4){
                checkAvailiabilityAndUpdate();
              }else{
                CustomAlert().buildAlert(context, "Invalid username!", "Username should contains atleast 4 charecters");
              }
              
            },
            icon: Icon(Icons.check),
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: textEditingController,
                  decoration: textInputDecoration.copyWith(
                    hintText: "Username"
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                (isAvailiable != null) ? (!isAvailiable ? Text("Username alredy taken! Try another", style: TextStyle(
                  color: Colors.black
                ),) : SizedBox()) : SizedBox(),
                
                
              ],
            ),
          )
        ],
      ),
    );
  }
}