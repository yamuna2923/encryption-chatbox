import 'package:encryptionChatBox/logic/auth/authLogic.dart';
import 'package:encryptionChatBox/ui-components/ui/alert/alertBox.dart';
import 'package:encryptionChatBox/ui-components/ui/buttons/buttons.dart';
import 'package:encryptionChatBox/ui-components/ui/forms/textInputDecoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailAndPasswordSignIn extends StatefulWidget {
  @override
  _EmailAndPasswordSignInState createState() => _EmailAndPasswordSignInState();
}

class _EmailAndPasswordSignInState extends State<EmailAndPasswordSignIn> {
  final formKey = GlobalKey<FormState>();
  String email, password;

  bool isSignining = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in"),
      ),
      body: ListView(
        children: [
          Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  Text("Log in", style: TextStyle(
                    fontFamily: "KumbhSans Bold",
                    fontSize: 35.0
                  ),),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Please signin to continue"),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text("Email Id"),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (String val){
                      if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)){
                        return "Invalid email";
                      }
                      return null;
                    },
                    decoration: textInputDecoration.copyWith(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email, color: Colors.red,)
                    ),
                    onSaved: (String val){
                      email = val.trim();
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Password"),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onSaved: (String val){
                      password = val.trim();
                    },
                    validator: (String val){
                      if(val.length < 6){
                        return "Password should have atleast 6 charecters!";
                      }
                      return null;
                    },
                    decoration: textInputDecoration.copyWith(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock, color: Colors.red,)
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  isSignining ? Center(
                    child: CircularProgressIndicator(),
                  ) : CustomButton().primaryButton("Log in", ()async{
                    setState(() {
                      isSignining = true;
                    });
                    if(formKey.currentState.validate()){
                      formKey.currentState.save();
                      await AuthLogic().signInWithEmailId(context, email, password);
                    }
                    setState(() {
                      isSignining = false;
                    });
                  }),
                  SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
                      },
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: "KumbhSans",
                            color: Colors.black
                          ),
                          children: [
                            TextSpan(text: "Forgot your password ? - "),
                            TextSpan(text: "Click here!", style: TextStyle(
                              fontFamily: "KumbhSans Bold"
                            )),
                          ]
                        ),
                      )
                    ),
                  
                  SizedBox(
                    height: 80.0,
                  ),
                  Center(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> EmailSignup()));
                      },
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: "KumbhSans",
                            color: Colors.black
                          ),
                          children: [
                            TextSpan(text: "Don't have an account ? - "),
                            TextSpan(text: "Sign up now!", style: TextStyle(
                              fontFamily: "KumbhSans Bold",
                              color: Colors.black
                            )),
                          ]
                        ),
                      )
                    ),
                  )




                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class EmailSignup extends StatefulWidget {
  @override
  _EmailSignupState createState() => _EmailSignupState();
}

class _EmailSignupState extends State<EmailSignup> {
  final formKey = GlobalKey<FormState>();
  String email, password, name;

  bool isSigninup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: ListView(
        children: [
          Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  Text("Sign up", style: TextStyle(
                    fontFamily: "KumbhSans Bold",
                    fontSize: 35.0
                  ),),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Please signup to continue"),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text("Your name"),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (String val){
                      if(val.trim().length < 3){
                        return "Invalid Name";
                      }
                      return null;
                    },
                    decoration: textInputDecoration.copyWith(
                      hintText: "Your name",
                      prefixIcon: Icon(Icons.person, color: Colors.red,)
                    ),
                    onSaved: (String val){
                      name = val.trim();
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Email Id"),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (String val){
                      if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)){
                        return "Invalid email";
                      }
                      return null;
                    },
                    decoration: textInputDecoration.copyWith(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email, color: Colors.red,)
                    ),
                    onSaved: (String val){
                      email = val.trim();
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Password"),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onSaved: (String val){
                      password = val.trim();
                    },
                    validator: (String val){
                      if(val.length < 6){
                        return "Password should have atleast 6 charecters!";
                      }
                      return null;
                    },
                    decoration: textInputDecoration.copyWith(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock, color: Colors.red,)
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  isSigninup ? Center(
                    child: CircularProgressIndicator(),
                  ) : CustomButton().primaryButton("Sign up", ()async{
                    setState(() {
                      isSigninup = true;
                    });
                    if(formKey.currentState.validate()){
                      formKey.currentState.save();
                      await AuthLogic().signUpWithEmailIdAndPassword(context, name, email, password);
                    }
                    setState(() {
                      isSigninup = false;
                    });
                  }),
                  SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: "KumbhSans",
                            color: Colors.black
                          ),
                          children: [
                            TextSpan(text: "Already have an account ? - "),
                            TextSpan(text: "Click here!", style: TextStyle(
                              fontFamily: "KumbhSans Bold",
                              color: Colors.black
                            )),
                          ]
                        ),
                      )
                    ),
                  
                  




                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final txtCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password?"),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 40.0,
                  ),
                  Text("Forgot Password?", style: TextStyle(
                    fontFamily: "KumbhSans Bold",
                    fontSize: 35.0
                  ),),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Reset your password"),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text("Email Id"),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: txtCtrl,
                    decoration: textInputDecoration.copyWith(
                      hintText: "Email ID",
                      prefixIcon: Icon(Icons.email, color: Colors.red,)
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomButton().primaryButton("Reset", (){
                    FirebaseAuth.instance.sendPasswordResetEmail(
                      email: txtCtrl.text
                    ).then((E){
                      CustomAlert().buildAlert(context, "Check your inbox!", "An email with password reset link was sent! Please check the mail in your inbox and reset your password.");
                    }).catchError((e){
                      print(e);
                      CustomAlert().buildAlert(context, "Error", e.message);
                    });
                  }),
              ],
            ),
          )
        ],
      ),
    );
  }
}