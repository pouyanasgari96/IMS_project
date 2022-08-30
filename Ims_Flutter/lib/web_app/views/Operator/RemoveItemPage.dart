// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:ims/Web_app/services/http_services.dart';

class removeItem extends StatefulWidget {
  const removeItem({Key? key}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<removeItem> {
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Image(
            image: AssetImage('images/logo.png'),
            height: 50,
          )),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Center(
                  child: Text(
                      "Please scan your RFID then click REMOVE button to remove the item",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2)),
            ),
            InkWell(
                child: Center(
                    child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: const Center(
                      child: Text("REMOVE",
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
                  await Httpservices.removeItem(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Item removed successfully")));
                }),
          ]),
    );
  }
}