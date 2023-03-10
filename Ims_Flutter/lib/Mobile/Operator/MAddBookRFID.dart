// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ims/Mobile/Operator/services/MOp_http_services.dart';

class MAddBookRFID extends StatefulWidget {
  final String Title;
  final String Author;
  final String Genre;
  final String Publisher;
  final String Date;
  final String Loc;
  final String Description;
  final String ImageUrl;

  const MAddBookRFID(
      {Key? key,
      required this.Title,
      required this.Author,
      required this.Genre,
      required this.Publisher,
      required this.Date,
      required this.Loc,
      required this.Description,
      required this.ImageUrl,
      context})
      : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<MAddBookRFID> {
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
              const Center(
                  child: Text("scan Book's RFID and press the button",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              InkWell(
                onTap: () async {
                  await HttpservicesOP.RfidReader(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('RFID READER'),
                          content: const Text("Please scan the Book's RFID"),
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
                                await HttpservicesOP.MobileAddItemNFC(
                                    widget.Title,
                                    widget.Author,
                                    widget.Genre,
                                    widget.Publisher,
                                    widget.Date,
                                    widget.Loc,
                                    widget.Description,
                                    widget.ImageUrl,
                                    "yes",
                                    context);
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: const Center(
                        child: Text("Add New Book",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    height: 100,
                    width: 1500,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await HttpservicesOP.MobileAddbook(
                      widget.Title,
                      widget.Author,
                      widget.Genre,
                      widget.Publisher,
                      widget.Date,
                      widget.Loc,
                      widget.Description,
                      widget.ImageUrl,
                      "no",
                      context);
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: const Center(
                        child: Text("Add New Book without RFID",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    height: 100,
                    width: 1500,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ]));
  }
}
