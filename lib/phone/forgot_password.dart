import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:online/phone/constants.dart';
class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Future<void> resetPassword(String email,) async {
firebase_auth.FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          Center(
            child: SizedBox(

              width: 350,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("If You can't remember your password input your email  to retreive"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
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
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.pink
                        ),
                        onPressed: () async {
                          firebase_auth.FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text);
                          _email.clear();
                          context.showErrorMessage(message: "Check you Email for the confirmation message");
                        },
                        child: Text("Send Request"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Confirm extends StatelessWidget {
  const Confirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("You have succesfull Sent Your Request. Check your email!!"),
      ),
    );
  }
}

