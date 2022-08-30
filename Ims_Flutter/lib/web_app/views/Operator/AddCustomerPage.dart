// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/Web_app/data/user_data.dart';
import 'package:ims/Web_app/model/user.dart';
import 'package:ims/Web_app/services/http_services.dart';
import 'package:ims/Web_app/views/DashBoard.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState();
}

// _RegisterPageState inherits the state of RegisterPage
class _GenreListState extends State<AddCustomer> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form
  final _formKey = GlobalKey<FormState>();
  // Register form data
  late String email;
  late String firstName;
  late String lastName;
  late String username;
  late String password;
  late String user_chk_flag;
  late User newUser;
  late int role;
  static const _roles =[
    "Customer",
    "Operator",
  ];
  String dropdownvalue = _roles[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Register page")),
        body: Form(
          key: _formKey,
          child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Center(
                    child: Text(
                      "Register New User",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent),
                      textAlign: TextAlign.center,
                      textScaleFactor: 2,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter first name",
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        firstName = value;
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
                      hintText: "Enter last name",
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        lastName = value;
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
                        hintText: "Enter username",
                        labelText: 'Username',
                        border: OutlineInputBorder()),
                    onChanged: (value) async {
                      setState(() {
                        username = value;
                      });
                      user_chk_flag =
                          await Httpservices.addCustomerCheck(username);
                      //if (user_chk_flag ==
                      //    "the entered username is used before") {
                      //  await EasyLoading.showInfo(user_chk_flag);
                      //}
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      } else if (user_chk_flag ==
                          "the entered username is used before") {
                        return user_chk_flag;
                      } else {}
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Enter email address",
                        labelText: 'Email',
                        border: OutlineInputBorder()),
                    onChanged: (value) {
                      setState(() {
                        email = value;
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
                        hintText: "Enter password",
                        labelText: 'Password',
                        border: OutlineInputBorder()),
                    onChanged: (value) {
                      setState(() {
                        password = value;
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
                        hintText: "Confirm password",
                        labelText: 'Password validation',
                        border: OutlineInputBorder()),
                    validator: (String? value) {
                      if (value != password) {
                        return 'Password is not correct';
                      }
                      return null;
                    },
                  ),
                ),
                selectRole(),
                InkWell(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: const Center(
                          child: Text("SUBMIT new user data",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepOrangeAccent),
                    ),
                    onTap: () async {
                      setState(() {
                        // The newUser added to pending Users such that it can be registered in the totem adding the RFID
                        newUser = User(
                          firstName : firstName, 
                          lastName : lastName, 
                          userName : username, 
                          email: email, 
                          imagePath: "https://img.icons8.com/ios-filled/50/000000/user-male-circle.png",
                          pwd: password,
                          news: "",
                          role: role);
                        UserData.addPendingUser(newUser);
                      });
                      if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          if (user_chk_flag == "username is valid") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DashBoard(user: UserData.myCustomer)));
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("User added to pending users list")));
                          } else {
                            await EasyLoading.showError(
                                "please change the entered username");
                          }
                        }
                      } else {}
                    })
              ]),
        ));
  }

  Row selectRole() {
    return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children : <Widget>[
                  const SizedBox(width: 25),
                  const Text("Select role : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),),
                  DropdownButton<String>(
                    value: dropdownvalue,
                    icon : const Icon(Icons.arrow_downward),
                    underline: Padding(
                  padding: const EdgeInsets.symmetric(horizontal : 30),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 5, width: 100, color: Colors.deepOrangeAccent),
                ),
                onChanged: (String? newValue){
                  setState(() {
                    dropdownvalue = newValue!;
                    role = (dropdownvalue == "Customer") ? 0 : 1;
                  });
                },
                items: _roles.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    child: Padding(
                      padding : const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Text(value)), 
                    value: value,
                  );
                }).toList(),
              ),
              ]
            );
  }
}