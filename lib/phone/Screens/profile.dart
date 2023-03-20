import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online/main.dart';
import 'package:online/phone/constants.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController old_pass = TextEditingController();
  TextEditingController new_pass = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final name = user!.displayName;
    final email = user!.email;
    final photo = user!.photoURL;

    String firstLetter = user.displayName!.substring(0, 1).toUpperCase();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 150,
                child: Card(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.indigo.shade900,
                          child: CircleAvatar(
                              radius: 48,
                              backgroundColor: Colors.white,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200.0),
                                  child: (photo == null)
                                      ? Text(
                                          "$firstLetter",
                                          style: TextStyle(
                                              fontSize: 40,
                                              color: Colors.black),
                                        )
                                      : Image.network('${photo}',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover))),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 38.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$name",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 170,
                              child: Text(
                                "$email",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.pink),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Colors.indigo.shade50,
                        leading: Icon(
                          Icons.email_outlined,
                          color: Colors.indigo.shade900,
                        ),
                        title: Text("$email"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Colors.indigo.shade50,
                        leading: Icon(
                          Icons.person,
                          color: Colors.indigo.shade900,
                        ),
                        title: Text("$name"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: old_pass,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.indigo.shade500,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            labelText: "Old Password",
                            filled: true,
                            fillColor: Colors.indigo.shade50,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: new_pass,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.indigo.shade500,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            labelText: "New Password",
                            filled: true,
                            fillColor: Colors.indigo.shade50,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        )),
                    SizedBox(height: 15),
                    SizedBox(
                      width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink
                          ),
                            onPressed: () async {
                              final user = await FirebaseAuth.instance.currentUser;
                              final cred = EmailAuthProvider.credential(
                                  email: email.toString(), password: old_pass.text);

                              user!.reauthenticateWithCredential(cred).then((value) {
                                user.updatePassword(new_pass.text).then((_) {
                                  old_pass.clear();
                                  new_pass.clear();
                                  context.showErrorMessage(message: "Successfully Changed");
                                  //Success, do something
                                }).catchError((error) {
                                  //Error, show something
                                  context.showErrorMessage(message: "$error");
                                });
                              }).catchError((err) {

                              });
                            }, child: Text("Submit")),

                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
