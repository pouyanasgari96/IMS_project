// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:ims/Totem/Operator/TAddBook.dart';
import 'package:ims/Totem/Operator/TRemoveBook.dart';
import 'package:ims/Totem/Operator/services/TOp_http_services.dart';

class TmodifyBook extends StatelessWidget {
  const TmodifyBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title:
                //Text("HELLO DEAR BOOK LOVER!"),
                const Image(
              image: AssetImage('images/logo.png'),
              height: 50,
            )),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Center(
                  child: Text("Please select a service", textScaleFactor: 1.5)),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TAddBook()));
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: const Center(
                        child: Text("Add Item",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    height: 80,
                    width: 1500,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TRemoveBook()));
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: const Center(
                        child: Text("Remove Item",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    height: 80,
                    width: 1500,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await Httpservices.PendingItems(context);
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: const Center(
                        child: Text("Pending list",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    height: 80,
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
