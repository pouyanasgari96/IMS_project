// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'services/MOp_http_services.dart';

class TLoginOperator extends StatefulWidget {
  const TLoginOperator({Key? key}) : super(key: key);
  @override
  _TLoginOperatorState createState() => _TLoginOperatorState();
}

class _TLoginOperatorState extends State<TLoginOperator> {
  // Global key that uniquely identifies the form widget and is used for validation
  final _formKey = GlobalKey<FormState>();
  // Login parameters
  late String username;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage('images/logo.png'),
          height: 50,
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //const Center(
            //    child: Text("Welcome ",
            //        textAlign: TextAlign.center,
            //        style: TextStyle(fontWeight: FontWeight.bold),
            //        textScaleFactor: 3)),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Center(
                        child: Text("Please enter your credentials",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                            textScaleFactor: 2)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Enter your username",
                          labelText: "Username",
                          border: OutlineInputBorder()),
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Enter your password",
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  InkWell(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: const Center(
                            child: Text("SUBMIT CREDENTIALS",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                        height: 50,
                        width: 800,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green),
                      ),
                      onTap: () async {
                        if (_formKey.currentState != null) {
                          if (_formKey.currentState!.validate()) {
                            await HttpservicesOP.MobileLoginCredentialOp(
                                username, password, context);
                            // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Success")));
                          }
                        } else {}
                      })
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Center(
                  child: Text("Or scan your RFID then click LOGIN button",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2)),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.green)))),
            InkWell(
                child: Center(
                    child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: const Center(
                      child: Text("LOGIN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  height: 50,
                  width: 800,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                )),
                onTap: () async {
                  await HttpservicesOP.RfidReader(context);
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
                                await HttpservicesOP.MobileLoginNFCOP(context);
                              },
                            ),
                          ],
                        );
                      });
                  //ScaffoldMessenger.of(context).showSnackBar(
                  //    const SnackBar(content: Text("Login Success")));
                }),
            // If wanted to implement with inf loop :
          ]),
    );
  }
}
