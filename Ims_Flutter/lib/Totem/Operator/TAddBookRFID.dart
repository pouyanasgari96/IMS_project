// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import './services/TOp_http_services.dart';

class TAddBookRFID extends StatefulWidget {
  final String Title;
  final String Author;
  final String Genre;
  final String Publisher;
  final String Date;
  final String Loc;
  final String Description;

  const TAddBookRFID(
      {Key? key,
      required this.Title,
      required this.Author,
      required this.Genre,
      required this.Publisher,
      required this.Date,
      required this.Loc,
      required this.Description,
      context})
      : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<TAddBookRFID> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Image(
              image: AssetImage('images/logo.png'),
              height: 50,
            )),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Center(
                  child: Text("scan Book's RFID and press the button",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              InkWell(
                onTap: () async {
                  await Httpservices.totemAddbook(
                      widget.Title,
                      widget.Author,
                      widget.Genre,
                      widget.Publisher,
                      widget.Date,
                      widget.Loc,
                      widget.Description,
                      context);
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: const Center(
                        child: Text("Add New Item",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    height: 100,
                    width: 1500,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ]));
  }
}
