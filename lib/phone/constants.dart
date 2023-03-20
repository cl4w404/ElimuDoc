
import 'package:flutter/material.dart';
extension ShowSnackBar on BuildContext {
  void showErrorMessage( {required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        content: Text(
      message,
      style: TextStyle(color: Colors.black),
    ),
            backgroundColor: Colors.pink.shade50,
    )
    );
  }
}

/*
Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(),
              child: Container(
                height: 50,
                width: 330,
                child: TextField(
                  onChanged: (val){
                    setState(() {
                      name=val;
                    });
                  },
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
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 125.0),
              child: Text(
                "Past Papers for ${widget.title}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 275.0),
              child: Text(
                "${widget.category}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.pink.shade900),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('subjects')
                    .doc(widget.title.trim())
                    .collection(widget.category.trim())
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(80.0),
                      child: RiveAnimation.asset('assets/loading.riv'),
                    );
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return ListTile(
                        leading: Container(
                          color: Colors.indigo,
                          width: 50,
                          height: 50,
                          child: Center(
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              if (data['paper'].toString() == "Paper 1") {
                                return Text(
                                  "P1",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                );
                              } else if (data['paper'].toString() ==
                                  "Paper 2") {
                                return Text(
                                  "P2",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                );
                              } else {
                                return Text(
                                  "P3",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                );
                              }
                            }),
                          ),
                        ),
                        title: Text(data['School']),
                        subtitle: Text(data['paper']),
                        trailing: InkWell(
                            onTap: () {},
                            child: Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.download_sharp,
                                  color: Colors.pink,
                                ))),
                      );
                    }).toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
 */
