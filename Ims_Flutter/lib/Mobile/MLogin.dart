// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:ims/Mobile/User/MLoginCredentials.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'Operator/MLoginOperator.dart';
import './User/services/MUs_http_services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nfc_manager/nfc_manager.dart';

class MLoginPage extends StatefulWidget {
  const MLoginPage({Key? key}) : super(key: key);
  @override
  _TLoginPageState createState() => _TLoginPageState();
}

class _TLoginPageState extends State<MLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage('images/logo.png'),
          height: 40,
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Center(
                    child: Image(
                        image: AssetImage('images/ims.jpg'),
                        height: 150,
                        width: 150))),
            const Center(
                child: Text("Welcome (MOBILE)",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 2)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Center(
                  child: Text(
                      "Please scan your RFID then click on the LOGIN button",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2)),
            ),
            InkWell(
                child: Center(
                    child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Center(
                      child: Text("LOGIN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  height: 40,
                  width: 600,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                )),
                onTap: () async {
                  await Httpservices.RfidReader(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('TAG READER'),
                          content: const Text('Please scan your Tag'),
                          actions: <Widget>[
                            TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white)),
                              child: const Text('CANCEL'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 68, 156, 71)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white)),
                              child: const Text('OK'),
                              onPressed: () async {
                                await Httpservices.MobileLoginNFC(context);
                                //await Httpservices.RfidReader(context);
                                //Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                }),
            // If wanted to implement with inf loop :
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.green)))),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                child: const Text(" * Login with Credentials * ",
                    style: TextStyle(
                        backgroundColor: Colors.green,
                        fontSize: 25,
                        color: Colors.black)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MLoginCredentials()));
                },
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                child: const Text(" * Login as Operator * ",
                    style: TextStyle(
                        backgroundColor: Colors.green,
                        fontSize: 25,
                        color: Colors.black)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TLoginOperator()));
                },
              ),
            )
          ]),
    );
  }
}
