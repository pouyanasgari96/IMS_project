// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/services/http_services.dart';
import 'package:ims/web_app/views/Operator/ManageItemsPage.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

// _RegisterPageState inherits the state of RegisterPage
class _GenreListState extends State<AddBook> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form
  final _formKey = GlobalKey<FormState>();
  // Register form data
  late String Publisher;
  late String Date;
  late String Title;
  late String Author;
  late String Genre;
  late String RFID;
  late String Loc;
  late String Description;
  late String branch;
  late String urlImage;

  static final _branchOp = [
    TheWebUser[0]['branch'].toString(),
  ];
  late List<String> _branch = [];
  static List<String> branchlist = [];
  static late String dropdownvaluebranch = 'New Branch';

  @override
  Widget build(BuildContext context) {
    if (TheWebUser[0]['role'] == 'operators') {
      _branch = _branchOp;
      branch = _branchOp[0];
    } else if (TheWebUser[0]['role'] == 'admins') {
      branchlist.clear();
      for (var i = 0; i < AllBranches.length; i++) {
        branchlist.add(AllBranches[i]);
      }
      branchlist.add('New Branch');
      _branch = branchlist;
    }
    double width_screen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: (Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const Image(
                image: AssetImage("images/ims.jpg"),
                width: 45,
                height: 45,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            const Text("Register new item page")
          ])),
        ),
        body: Center(
          child: SizedBox(
            width: width_screen * 0.7,
            child: Form(
              key: _formKey,
              child: ListView(children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Center(
                    child: Text(
                      "Item details".toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7)),
                      textAlign: TextAlign.center,
                      textScaleFactor: 3,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter the Book's Title",
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        Title = value;
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter the Book's Author",
                      labelText: 'Author',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        Author = value;
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter the Book's Genre",
                      labelText: 'Genre',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        Genre = value;
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter the Book's Publisher",
                      labelText: 'Publisher',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        Publisher = value;
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter the Book's Date",
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        Date = value;
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter the Book's Location",
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        Loc = value;
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter the Book's Description",
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        Description = value;
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter the url of the image",
                      labelText: 'Image url',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        urlImage = value;
                      });
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        urlImage =
                            'https://smallimg.pngkey.com/png/small/12-122439_book-icon-book-flat-icon-png.png';
                      }
                      return null;
                    },
                  ),
                ),
                (TheWebUser[0]['role'] == 'admins')
                    ? (selectBranch())
                    : (const SizedBox(
                        height: 5,
                      )),
                const SizedBox(
                  height: 10,
                ),
                SubmitItem(context, width_screen)
              ]),
            ),
          ),
        ));
  }

  TextButton SubmitItem(BuildContext context, double width_screen) {
    return TextButton(
      onPressed: () {
        if (_formKey.currentState != null) {
          if (_formKey.currentState!.validate()) {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Item confirmation'),
                content: const Text(
                    'Are you sure you want to add the item withouth rfid ?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await Httpservices.webAddbook(
                          Title,
                          Author,
                          Genre,
                          Publisher,
                          Date,
                          Loc,
                          Description,
                          "no",
                          branch,
                          urlImage,
                          context);
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            );
          }
        }
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: const Center(
              child: Text("SUBMIT NEW ITEM",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20))),
          height: 60,
          width: width_screen * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: <Color>[
                Color.fromARGB(255, 22, 78, 163),
                Color(0xFF1976D2),
                Color.fromARGB(255, 36, 121, 190),
              ],
            ),
          )),
    );
  }

  Row selectBranch() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      const SizedBox(width: 25),
      const Text(
        "Select branch : ",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      ),
      DropdownButton<String>(
        value: dropdownvaluebranch,
        icon: const Icon(Icons.arrow_downward),
        underline: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
              alignment: Alignment.centerLeft,
              height: 5,
              width: 100,
              color: Colors.lightBlue),
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownvaluebranch = newValue!;
            branch = dropdownvaluebranch;
          });
        },
        items: _branch.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(value)),
            value: value,
          );
        }).toList(),
      ),
    ]);
  }
}
