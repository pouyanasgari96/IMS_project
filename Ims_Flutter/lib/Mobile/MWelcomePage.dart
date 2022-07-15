// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'MLogin.dart';

class MWelcome extends StatelessWidget {
  const MWelcome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
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
                  child: Text("Hello dear book lover!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 3)),
              const Center(
                  child: Text("Welcome to the MOBILE APP",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2)),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Center(
                      child: Image.asset('images/bookies.png',
                          width: 500, height: 300))),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TLoginPage()));
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    child: const Center(
                        child: Text("Enter",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    height: 100,
                    width: 1000,
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
