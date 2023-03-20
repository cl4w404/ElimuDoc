import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online/config.dart';
import 'package:online/main.dart';
import 'package:online/phone/Verify.dart';
import 'package:online/phone/constants.dart';
import 'package:online/phone/mobile_login.dart';
import 'package:rive/rive.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class mobile_register extends StatefulWidget {
  const mobile_register({Key? key}) : super(key: key);

  @override
  _mobile_registerState createState() => _mobile_registerState();
}

class _mobile_registerState extends State<mobile_register> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController CountryController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberlController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(280))),
                height: 692,
                child: Column(
                  children: [],
                ),
              ),
              Container(
                child: ListView(
                  children: [
                    SizedBox(
                        height: 170,
                        child: RiveAnimation.asset('assets/new_file.riv')),
                    Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? 'Enter a valid email'
                                    : null,
                            controller: _emailController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.indigo.shade500,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              labelText: "Email",
                              filled: true,
                              fillColor: Colors.indigo.shade50,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                          SizedBox(
                            height: 11,
                          ),
                          TextFormField(
                            controller: _nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter A Valid Name';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.indigo.shade500,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              labelText: "Your name",
                              filled: true,
                              fillColor: Colors.indigo.shade50,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                          SizedBox(
                            height: 11,
                          ),
                          TextFormField(
                            controller: CountryController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter A Valid School';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.place,
                                color: Colors.indigo.shade500,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              labelText: "e.g Starehe boys",
                              filled: true,
                              fillColor: Colors.indigo.shade50,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                          SizedBox(
                            height: 11,
                          ),
                          TextFormField(
                            controller: _numberlController,
                            validator: (value) {
                              if (!value!.startsWith("+")) {
                                return 'Start with +254';
                              } else {}
                              return null;
                            },
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.smartphone_outlined,
                                color: Colors.indigo.shade500,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              labelText: "e.g +254712345678",
                              filled: true,
                              fillColor: Colors.indigo.shade50,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                          SizedBox(
                            height: 11,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.length < 7) {
                                return 'Enter an 8 digit password';
                              }
                              return null;
                            },
                            controller: _pwdController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password,
                                color: Colors.indigo.shade500,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              labelText: "Password",
                              filled: true,
                              fillColor: Colors.indigo.shade50,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => mobile_login()));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 18.0, left: 120),
                              child: Text(
                                "Already a user? click me",
                                style: TextStyle(color: Colors.pink),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 36,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 98.0),
                            child: SizedBox(
                              width: 200,
                              height: 41,
                            ),
                          ),
                        ],
                      ),
                    )
                    // end of padding
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.indigo.shade900,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(200))),
                height: 620,
              ),
              Positioned(
                top: 625,
                left: 130,
                child: SizedBox(
                  width: 200,
                  height: 41,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      Future.delayed(const Duration(seconds: 7), () async {
                        setState(() {
                          _isLoading = false;
                        });
                      });
                      if (_formKey.currentState!.validate()) {
                        try {
                          firebase_auth.UserCredential userCredential =
                              await firebaseAuth.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _pwdController.text,
                          );
                          await userCredential.user
                              ?.updateDisplayName("${_nameController.text}");
                          final User? user = auth.currentUser;
                          final uid = user!.uid;
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .set({
                                "name": _nameController.text,
                                "email": _emailController,
                                "School": CountryController.text,
                                "phone": _numberlController.text,
                                "createdAt": Timestamp.now(),
                                "Id": uid,
                              })
                              .then((value) => print("user added"))
                              .catchError((error) =>
                                  print("Failed to add user: $error"));
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => VerifyUser()),
                              (route) => false);
                        } catch (e) {
                          final snackbar = SnackBar(
                              content: Text(
                            e.toString(),
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                        context.showErrorMessage(
                            message: "Welcome ${_emailController.text} 😀");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                    ),
                    child: _isLoading
                        ?
                    CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
