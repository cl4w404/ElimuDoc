import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online/phone/mobile_register.dart';
import 'package:rive/rive.dart';

class MobileDisplay extends StatefulWidget {
  MobileDisplay({Key? key}) : super(key: key);

  @override
  _MobileDisplayState createState() => _MobileDisplayState();
}

class _MobileDisplayState extends State<MobileDisplay> {
  Artboard? _artboard;
  StateMachineController? _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootBundle.load('assets/work.riv').then((data) async {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      var controller = StateMachineController.fromArtboard(artboard, 'work');
      if (controller != null) {
        artboard.addController(controller);
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(280))),
                  height: 692,
                ),
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 250,
                          child: RiveAnimation.asset('assets/work.riv')),
                      Text(
                        "ElimuDoc",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 32.0),
                          child: Text(
                            "This is the best study partner son far. Here you will get free past papers from Form 1- Form 4 with no hidden charges",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Center(
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>mobile_register()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,

                            ),
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade900,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(200))),
                  height: 620,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
