import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
//import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:online/phone/Screens/view_pdf.dart';
import 'package:online/phone/ad/BarnnerAd.dart';
import 'package:online/phone/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rive/rive.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class FormOne extends StatefulWidget {
  FormOne({Key? key, required this.category, required this.title})
      : super(key: key);
  String category;
  String title;

  @override
  _FormOneState createState() => _FormOneState();
}

class _FormOneState extends State<FormOne> {
  String name = "";
  RewardedAd? rewardedAd;
  late RewardedAd _rewardedAd;
  bool _isRewardedAdLoaded= false;

  bool isLoaded = false;
  Future<void> downloadURLExample({var namepdf}) async {
    //Here you'll specify the file it should download from Cloud Storage
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('product/$namepdf')
        .getDownloadURL();
    print(downloadURL);
    //PDFDocument doc = await PDFDocument.fromURL(downloadURL);
    PDFDocument _doc = await PDFDocument.fromURL(downloadURL);
    //You can download a single file
    FileDownloader.downloadFile(
        url: downloadURL,
        name: namepdf,
        onProgress: (fileName, double progress) {
          LinearProgressIndicator(
            value: progress,
          );
          print('FILE $fileName HAS PROGRESS $progress');
        },
        onDownloadCompleted: (String path) {
          context.showErrorMessage(
              message:
                  "${namepdf} finished downloding 😁  check your Downloads folder!! ");
          print('FILE DOWNLOADED TO PATH: $path');
        },
        onDownloadError: (String error) {
          print('DOWNLOAD ERROR: $error');
        });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewPdf(
                  document: _doc,
                ))); //Notice the Push Route once this is done.
  }

  @override
  void initState() {
    super.initState();
    downloadURLExample();
    RewardedAd.load(
      adUnitId: "ca-app-pub-7995558881059154/3545289880",
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                _isRewardedAdLoaded = false;
              });
            },
          );
          setState(() {
            _isRewardedAdLoaded = true;
          });
        },
        onAdFailedToLoad: (err) {
          setState(() {
            _isRewardedAdLoaded = false;
          });
        },
      ),
    );
  }
  @override

  void dispose() {
    // TODO: implement dispose
    _rewardedAd.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onChanged: (val) {
                    setState(() {
                      name = val;
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
                    hintText: "eg: Alliance or 2  ",
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Colors.pink,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Past Papers for ${widget.title}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 280.0),
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
                  builder: (context, snapshots) {
                    return (snapshots.connectionState ==
                            ConnectionState.waiting)
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(80.0),
                              child: RiveAnimation.asset('assets/loading.riv'),
                            ),
                          )
                        : ListView.builder(
                            itemCount: snapshots.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshots.data!.docs[index].data()
                                  as Map<String, dynamic>;

                              if (name.isEmpty) {
                                return ListTile(
                                  onTap: () async {
                                    _rewardedAd.show(
                                        onUserEarnedReward:
                                            (ad, reward) async {
                                              downloadURLExample(
                                                  namepdf: data['file_name']);
                                            });

                                  },
                                  leading: Container(
                                    color: Colors.indigo,
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                      child: LayoutBuilder(
                                          builder: (context, constraints) {
                                        if (data['paper'].toString() ==
                                            "Paper 1") {
                                          return Text(
                                            "P1",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          );
                                        } else if (data['paper'].toString() ==
                                            "Paper 2") {
                                          return Text(
                                            "P2",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          );
                                        } else {
                                          return Text(
                                            "P3",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          );
                                        }
                                      }),
                                    ),
                                  ),
                                  title: Text(data['School']),
                                  subtitle: Text(
                                      "${data['paper']} done in ${data['year']} term ${data['term']}"),
                                  trailing: Container(
                                      height: 50,
                                      width: 50,
                                      child: Icon(
                                        Icons.download_sharp,
                                        color: Colors.pink,
                                      )),
                                );
                              }
                              if (data['paper']
                                      .toString()
                                      .contains(name.toLowerCase()) ||
                                  data['School'].toString().startsWith(name)) {
                                return ListTile(
                                  selectedTileColor: Colors.pink.shade50,
                                  onTap: () async {
                                    _rewardedAd.show(
                                        onUserEarnedReward:
                                            (ad, reward) async {
                                          downloadURLExample(
                                              namepdf: data['file_name']);
                                        });
                                  },
                                  leading: Container(
                                    color: Colors.indigo,
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                      child: LayoutBuilder(
                                          builder: (context, constraints) {
                                        if (data['paper'].toString() ==
                                            "Paper 1") {
                                          return Text(
                                            "P1",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          );
                                        } else if (data['paper'].toString() ==
                                            "Paper 2") {
                                          return Text(
                                            "P2",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          );
                                        } else {
                                          return Text(
                                            "P3",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          );
                                        }
                                      }),
                                    ),
                                  ),
                                  title: Text(data['School']),
                                  subtitle: Text(
                                      "${data['paper']} done in ${data['year']} term ${data['term']}"),
                                  trailing: Container(
                                      height: 50,
                                      width: 50,
                                      child: Icon(
                                        Icons.download_sharp,
                                        color: Colors.pink,
                                      )),
                                );
                              }
                              return Container(
                                child: Text("There is a problem"),
                              );
                            });
                  }),
            ),
            CustomBannerAd()
          ],
        ),
      ),
    );
  }
}
