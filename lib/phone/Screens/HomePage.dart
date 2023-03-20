import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online/class/course_model.dart';
import 'package:online/phone/Screens/ShareDoc.dart';
import 'package:online/phone/Screens/category_each.dart';
import 'package:online/phone/Screens/info.dart';
import 'package:online/phone/Screens/profile.dart';
import 'package:online/phone/ad/BarnnerAd.dart';
import 'package:share/share.dart';

import '../../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name="";
  final GlobalKey<ScaffoldState> _formKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final name = user!.displayName;
    final photo = user!.photoURL;

    String firstLetter = user.displayName!.substring(0, 1).toUpperCase();

    void update(String value) {
      List<Course> category = List.from(course);
      setState(() {
        category = course
            .where((element) =>
                element.Title.toString().contains(value.toLowerCase()))
            .toList();
      });
    }

    return Scaffold(
        key: _formKey,
        backgroundColor: Colors.white,
        drawer: Drawer(
          backgroundColor: Colors.indigo.shade900,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(200.0),
                          child: (photo == null)
                              ? Text(
                                  "$firstLetter",
                                  style: TextStyle(fontSize: 40),
                                )
                              : Image.network('${photo}',
                                  width: 100, height: 100, fit: BoxFit.cover))),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.indigo.shade900),
                title: Center(
                    child: Text(
                  '$name',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontStyle: FontStyle.italic),
                )),
                trailing: Icon(Icons.arrow_forward_ios,
                    color: Colors.indigo.shade900),
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: const Text(
                  'Profile',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile(),
                      ));
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(Icons.share, color: Colors.white),
                title: const Text(
                  'Share App With School Mates',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink),
                onTap: () {
                  Navigator.pop(context);
                  Share.share("https://play.google.com/store/apps/details?id=com.DevCorp.online");

                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline, color: Colors.white),
                title: const Text(
                  'About ElimuDoc',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Info()),);
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: InkWell(
                        onTap: () {
                          _formKey.currentState!.openDrawer();
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32.0),
                            color: Colors.white70,
                          ),
                          child: CircleAvatar(
                              backgroundColor: Colors.indigo.shade900,
                              maxRadius: 32.0,
                              child: Icon(
                                Icons.menu,
                                color: Colors.pink,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Container(
                        height: 50,
                        width: 250,
                        child: TextField(
                          onChanged: (value) => update(value),
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.indigo.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "eg: Kiswahili",
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: Colors.pink,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: course.length,
                    itemBuilder: (BuildContext context, int index) => CourseEx(
                          course: course[index],
                        )),
              ),
              CustomBannerAd()
            ],
          ),
        ));
  }
}

class CourseEx extends StatelessWidget {
  const CourseEx({Key? key, required this.course}) : super(key: key);
  final Course course;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryEach(
                  course: course,
                )));
      },
      child: Card(
          child: Center(
        child: Row(
          children: [
            Container(
                height: 100,
                width: 70,
                color: Colors.white,
                child: SvgPicture.asset(course.Image.toString())),
            Container(
              color: Colors.indigo.shade50,
              height: 100,
              width: 82,
              child: Center(child: Text(course.Title)),
            ),
          ],
        ),
      )),
    );
  }
}
