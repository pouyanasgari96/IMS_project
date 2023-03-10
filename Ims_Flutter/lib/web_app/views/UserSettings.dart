// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/views/components/profile_widget.dart';
import './../services/http_services.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);
  
  //NOTE : in a dart if an identifier start with '_' then it is private to its library
  @override
  _SettingPageState createState() => _SettingPageState();
}

late String NEWfirstname = TheWebUser[0]['firstname'];
late String NEWlastname = TheWebUser[0]['lastname'];
late String NEWusername = TheWebUser[0]['username'];
late String NEWmail = TheWebUser[0]['mail'];
late String NEWpwd = TheWebUser[0]['pwd'];

late bool _obscureText = true;
class _SettingPageState extends State<SettingPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width_screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: (
            Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const Image(
                  image: AssetImage("images/ims.jpg"),
                  width: 45,
                  height: 45,
                ),
              ),
              const SizedBox(width: 30,),
              const Text("Settings page")
            ])
          ),
        ),
      body: Center(
        child: Container(
          width: width_screen*0.7,
          child: Form(
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                children: <Widget>[
                  const SizedBox(height: 30),
                  ProfileWidget(
                    imagePath: TheWebUser[0]['imagePath'],
                    isEdit: true,
                    onClicked: () async {},
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "First Name",
                    ),
                    initialValue: TheWebUser[0]['firstname'],
                    onChanged: (value) {
                      NEWfirstname = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Last Name",
                    ),
                    initialValue: TheWebUser[0]['lastname'],
                    onChanged: (value) {
                      NEWlastname = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Username",
                    ),
                    initialValue: TheWebUser[0]['username'],
                    onChanged: (value) async {
                      await Httpservices.usrcheck(value, context);
                      NEWusername = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                    initialValue: TheWebUser[0]['mail'],
                    onChanged: (value) {
                      NEWmail = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap:(){
                            setState(() {
                             _obscureText = !_obscureText;
                                  });
                          },
                          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off)
                        ),
                      ),
                    ),
                    initialValue: TheWebUser[0]['pwd'],
                    onChanged: (value) {
                      NEWpwd = value;
                    },
                    obscureText: _obscureText,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      } 
                      return null;
                    },
                  ),
                  const SizedBox(height: 80),
                  InkWell(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 60),
                        height: 50,
                        child: const Center(
                            child: Text("Save",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue),
                      ),
                      onTap: () async {
                        if (Httpservices.username_valid == true) {
                          await Httpservices.settings(NEWfirstname, NEWlastname,
                              NEWusername, NEWmail, NEWpwd, context);
                        } else {
                          await EasyLoading.showError("The Username is not valid");
                        }
                      })
                ]),
          ),
        ),
      ),
    );
  }
}
