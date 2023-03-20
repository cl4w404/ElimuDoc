import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:online/phone/Verify.dart';
import 'package:online/phone/constants.dart';
import 'package:online/phone/forgot_password.dart';
import 'package:online/phone/mobile_register.dart';
import 'package:rive/rive.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class mobile_login extends StatefulWidget {
  const mobile_login({Key? key}) : super(key: key);

  @override
  _mobile_loginState createState() => _mobile_loginState();
}

class _mobile_loginState extends State<mobile_login> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // This function will be triggered when the button is pressed
  void _startLoading() async {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.indigo.shade900,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(280))),
                    height: 620,
                    child: ListView(
                      children: [
                        SizedBox(
                            height: 200,
                            child: RiveAnimation.asset('assets/new_file.riv')),
                        Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30),
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (email) => email != null &&
                                        !EmailValidator.validate(email)
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
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  labelText: "Email",
                                  filled: true,
                                  fillColor: Colors.indigo.shade50,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                obscureText: true,
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
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
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
                                          builder: (context) =>
                                              ForgotPassword()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 18.0, left: 120),
                                  child: Text(
                                    "Forgotten your password?",
                                    style: TextStyle(color: Colors.pink),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        //end of padding
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 85.0),
                child: SizedBox(
                  width: 200,
                  height: 41,
                  child: ElevatedButton(
                    onPressed: () async {


                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        Future.delayed(const Duration(seconds: 60), () async {
                          setState(() {
                            _isLoading = false;
                          });
                        });
                        try {
                          firebase_auth.UserCredential userCredential =
                              await firebaseAuth.signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _pwdController.text);
                          print(userCredential.user!.displayName);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => VerifyUser()),
                              (route) => false);
                        } catch (e) {
                          final snackbar =
                              SnackBar(content: Text(e.toString()));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                        context.showErrorMessage(
                            message:
                                "Welcome Back ${_emailController.text}😃!!");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
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
