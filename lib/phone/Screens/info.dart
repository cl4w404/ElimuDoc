import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Info extends StatefulWidget {
  Info({Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          width: 250,
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.indigo.shade900,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(170.0),
                    child: Image.asset("assets/image/ElimuDoc.png")),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "ElimuDoc",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Version: 1.0.1",
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  String URL = "https://github.com/cl4w404/privacy-pol/blob/main/privacy-policy.md";
                  launchURL(URL);
                },
                  child: Text(
                "Privacy Policy",
                style: TextStyle(color: Colors.indigo.shade900),
              ))
            ],
          ),
        ),
      ),
    );
  }
  launchURL(String url) async {
    if (await  launchURL(url)) {
      print("object");
    } else {
      throw 'Could not launch $url';
    }
  }
}


