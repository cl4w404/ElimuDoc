import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online/class/course_model.dart';
import 'package:online/phone/Screens/Forms/form_four.dart';
import 'package:online/phone/Screens/Forms/form_one.dart';
import 'package:online/phone/Screens/Forms/form_three.dart';
import 'package:online/phone/Screens/Forms/form_two.dart';
import 'package:online/phone/Screens/Forms/kcse.dart';
import 'package:online/phone/ad/BarnnerAd.dart';
import 'package:rive/rive.dart';

class CategoryEach extends StatefulWidget {
  CategoryEach({Key? key, required this.course}) : super(key: key);
  final Course course;
  @override
  _CategoryEachState createState() => _CategoryEachState();
}

class _CategoryEachState extends State<CategoryEach> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(height: 20,),
          Text(
            widget.course.Title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20,),
          Column(
            children: [
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormOne(category: '${widget.course.Form1}', title: '${widget.course.Title}',
                      )));
                },
                title: Text(widget.course.Form1),
                subtitle: Text("Past papers for ${widget.course.Form1}", style: TextStyle(color: Colors.indigo.shade900),),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.pink,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormTwo(category: '${widget.course.Form2}', title: '${widget.course.Title}',
                      )));
                },
                title: Text(widget.course.Form2),
                subtitle: Text("Past papers for ${widget.course.Form2}", style: TextStyle(color: Colors.indigo.shade900)),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.pink,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormThree(category: '${widget.course.Form3}', title: '${widget.course.Title}',
                      )));
                },
                title: Text(widget.course.Form3),
                subtitle: Text("Past papers for ${widget.course.Form3}", style: TextStyle(color: Colors.indigo.shade900),),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.pink,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FormFour(category: '${widget.course.Form4}', title: '${widget.course.Title}',
                      )));
                },
                title: Text(widget.course.Form4),
                subtitle: Text("Past papers for ${widget.course.Form4}", style: TextStyle(color: Colors.indigo.shade900)),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.pink,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Kcse(category: '${widget.course.kcse}', title: '${widget.course.Title}',
                      )));
                },
                title: Text(widget.course.kcse),
                subtitle: Text("${widget.course.kcse} past papers", style: TextStyle(color: Colors.indigo.shade900)),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.pink,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomBannerAd(),
            ],
          ),
        ],
      ),
    ));
  }
}
