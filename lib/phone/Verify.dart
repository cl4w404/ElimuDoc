import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online/phone/Screens/HomePage.dart';
class VerifyUser extends StatefulWidget {
  const VerifyUser({Key? key}) : super(key: key);

  @override
  _VerifyUserState createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  bool isEmailVerified= false;
  var timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified= FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isEmailVerified){
      sendVerificationEmail();
       timer = Timer.periodic(Duration(seconds: 3), (_)=>checkEmailVerified());
    }
  }
  Widget build(BuildContext context) =>isEmailVerified 
  ? HomePage(): Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.indigo.shade900,
      title: Text("ElimuDoc"),
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left:40.0, right:40,top: 150),
          child: SizedBox(
            height: 150,
            child: Card(
              color: Colors.pink.shade50,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 40),
                child: Text("Login to your email and verify your ElimuDoc account To Continue", style: TextStyle(fontSize: 18),),
              ),
            ),
          ),
        )
      ],
    ),
  );

  Future sendVerificationEmail() async{
    try{
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
    } catch (e){
      final snackbar = SnackBar(content: Text(e.toString(),));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel;
  }

 Future checkEmailVerified() async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
 }
}
