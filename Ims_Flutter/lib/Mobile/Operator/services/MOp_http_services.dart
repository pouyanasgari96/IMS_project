// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names, file_names, avoid_types_as_parameter_names

import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// to display loading animation
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/Mobile/DataLists.dart';
import 'package:ims/Mobile/Operator/MModifyBook.dart';
import 'package:ims/Mobile/Operator/MModifyCustomer.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
// to route
import '../../../routes.dart';
import '../../ListIUsers.dart';
import '../../ListItems.dart';
import '../MHomePage_op.dart';
import '../MRemoveCustomer.dart';

late int res = 0;
late List<int> mergedList = [];

String baseUrlMobile = 'http://' + (Myroutes.IPaddress) + ':5000';
String ListCustomers = baseUrlMobile + '/mobile/ListCustomers/';
String AddCustomerCheck = baseUrlMobile + '/mobile/AddCustomerCheck/';
String AddCustomerCheckNFC = baseUrlMobile + '/mobile/AddItemCheck/';
String AddCustomer = baseUrlMobile + '/mobile/AddCustomer/';
String RemoveCustomer = baseUrlMobile + '/mobile/RemoveCustomer/';
String RemoveCustomerNFC = baseUrlMobile + '/mobile/RemoveCustomerNFC/';
String MobileAddBook = baseUrlMobile + '/mobile/AddBook/';
String MobileRmBook = baseUrlMobile + '/mobile/RemoveBook/';
String MobileRmBookNFC = baseUrlMobile + '/mobile/RemoveBookNFC/';
String MobileLoginNFCopurl = baseUrlMobile + '/mobile/OprLoginNFC/';
String MobileAddItemCheckurl = baseUrlMobile + '/mobile/AddItemCheck/';

class HttpservicesOP {
  static final _client = http.Client();
  static final _MobileOprLoginCredentialUrl =
      Uri.parse(baseUrlMobile + '/mobile/OprLoginCredential');

  // Login with rfid method
  static MobileLoginNFCOP(context) async {
    if (res == 0) {
      await EasyLoading.showSuccess("The card has not been scanned");
    } else {
      http.Response response =
          await _client.get(MobileLoginNFCopurl + res.toString());
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json[0] == "not found") {
          await EasyLoading.showError("User not found");
        } else {
          TheUser.clear();
          TheUser.addAll(json);
          await EasyLoading.showSuccess(
              "Welcome Back " + TheUser[0]['firstname']);
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const hmpage_op()));
        }
      } else {
        EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
      }
    }
  }

  static RfidReader(context) async {
    if (await NfcManager.instance.isAvailable()) {
      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          var ppphex = (NfcA.from(tag)?.identifier ?? Uint8List(0));
          res = 0;
          mergedList = [for (var sublist in ppphex) sublist];
          for (int i = 0; i < 4; i++) {
            int temp = mergedList[3 - i] * pow(2, 8 * i).toInt();
            res += temp;
          }
          NfcManager.instance.stopSession();
        },
      );
    } else {
      await EasyLoading.showError("NFC sensor not detected");
    }
  }

  // Login with credentials method
  static MobileLoginCredentialOp(userName, password, context) async {
    http.Response response = await _client.post(_MobileOprLoginCredentialUrl,
        body: {"userName": userName, "password": password});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not found") {
        await EasyLoading.showError(json[0]);
      } else {
        TheUser.clear();
        TheUser.addAll(json);
        await EasyLoading.showSuccess(
            "Welcome Back " + TheUser[0]['firstname']);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const hmpage_op()));
        //Navigator.push(context,
        //    MaterialPageRoute(builder: (context) => const modifyCustomer()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

// Settings ************************************************************
  static bool username_valid = true;
  static usrcheck(value, context) async {
    http.Response response = await _client.get(Uri.parse(baseUrlMobile +
        "/mobile/usrcheck/operators/" +
        TheUser[0]['admin_id'].toString() +
        '/' +
        TheUser[0]['username'] +
        '/' +
        value));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json == "ok") {
        username_valid = true;
      } else {
        username_valid = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(json)));
      }
    } else {
      await EasyLoading?.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  static settings(
      NEWfirstname, NEWlastname, NEWusername, NEWmail, NEWpwd, context) async {
    http.Response response = await _client.post(
        Uri.parse(baseUrlMobile +
            "/mobile/settings/operators/" +
            TheUser[0]['username']),
        body: {
          "firstname": NEWfirstname,
          "lastname": NEWlastname,
          "username": NEWusername,
          "mail": NEWmail,
          "password": NEWpwd,
        });
    if (response.statusCode == 200) {
      TheUser[0]['firstname'] = NEWfirstname;
      TheUser[0]['lastname'] = NEWlastname;
      TheUser[0]['username'] = NEWusername;
      TheUser[0]['mail'] = NEWmail;
      TheUser[0]['pwd'] = NEWpwd;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User edited successfully")));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const hmpage_op()));
    } else {
      await EasyLoading?.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
// Settings ************************************************************

  // List Customers
  static MobileListCustomers(context) async {
    http.Response response = await _client.get(Uri.parse(ListCustomers +
        TheUser[0]['admin_id'].toString() +
        '/' +
        TheUser[0]['branch'].toString()));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "not_found") {
        EasyLoading.showError("There are No Customers");
      } else {
        await EasyLoading.showSuccess("There are some Customers");
        AllUsers.clear();
        AllUsers.addAll(json);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ListUsers()));
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }

  // Add customer check
  static totemAddCustomerCheck(username) async {
    http.Response response = await _client.post(
        AddCustomerCheck +
            TheUser[0]['admin_id'].toString() +
            '/' +
            TheUser[0]['rfid'].toString() +
            '/' +
            TheUser[0]['branch'].toString(),
        body: {"username": username});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json[0];
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }

  // Add customer method
  static MobileAddCustomer(
    firstName,
    lastName,
    username,
    email,
    password,
    rfid_flag,
    context,
  ) async {
    http.Response response = await _client.post(
        AddCustomer +
            TheUser[0]['admin_id'].toString() +
            '/' +
            TheUser[0]['rfid'].toString() +
            '/' +
            TheUser[0]['branch'].toString(),
        body: {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "username": username,
          "password": password,
          "rfid_flag": rfid_flag,
          "rfid_value": "0",
        });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "new User added to the database successfully") {
        await EasyLoading.showSuccess(json[0]);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const hmpage_op()));
      } else {
        await EasyLoading.showError(json[0]);
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }

  // Add customer with NFC
  static MobileAddCustomerNFC(
    firstName,
    lastName,
    username,
    email,
    password,
    rfid_flag,
    context,
  ) async {
    if (res == 0) {
      await EasyLoading.showSuccess("The Item has not been scanned");
    } else {
      http.Response response = await _client.get(AddCustomerCheckNFC +
          TheUser[0]['admin_id'].toString() +
          '/' +
          TheUser[0]['branch'].toString() +
          '/' +
          res.toString());
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json[0] == "not found") {
          await EasyLoading.showSuccess("RFID is new");
          http.Response response1 = await _client.post(
              AddCustomer +
                  TheUser[0]['admin_id'].toString() +
                  '/' +
                  TheUser[0]['rfid'].toString() +
                  '/' +
                  TheUser[0]['branch'].toString(),
              body: {
                "firstName": firstName,
                "lastName": lastName,
                "email": email,
                "username": username,
                "password": password,
                "rfid_flag": rfid_flag,
                "rfid_value": res.toString(),
              });
          if (response1.statusCode == 200) {
            await EasyLoading.showSuccess(
                "The Item has been registered successfully");
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const modifyCustomer()));
          } else {
            EasyLoading.showError(
                "Error Code : ${response1.statusCode.toString()}");
          }
        } else {
          await EasyLoading.showError(json[0]);
          Navigator.pop(context);
        }
      } else {
        EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
      }
    }
  }

  // Remove customer
  static RemoveCheck(cst_username, usrn_rfid, context) async {
    http.Response response = await _client.post(
        RemoveCustomer +
            TheUser[0]['admin_id'].toString() +
            '/' +
            TheUser[0]['branch'].toString(),
        body: {"cst_username": cst_username, "usrn_rfid": usrn_rfid});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "no") {
        await EasyLoading.showError('User Not Found');
      } else {
        await EasyLoading.showSuccess('User removed successfully');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TRemoveCustomer()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Remove Customer NFC
  static MobileRemoveCustomerNFC(context) async {
    if (res == 0) {
      await EasyLoading.showSuccess("The Item has not been scanned");
    } else {
      http.Response response = await _client.get(
        RemoveCustomerNFC +
            TheUser[0]['admin_id'].toString() +
            '/' +
            TheUser[0]['branch'].toString() +
            '/' +
            res.toString(),
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json[0] == "done") {
          await EasyLoading.showSuccess("Customer removed successfully");
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const modifyCustomer()));
        } else {
          Navigator.pop(context);
          await EasyLoading.showError("The Customer is not in the database");
        }
      } else {
        EasyLoading.showError("Error code : ${response.statusCode.toString()}");
      }
    }
  }

//#############################################################################

  // List ALL Items
  static List_All_Items(context) async {
    http.Response response = await _client.get(Uri.parse(baseUrlMobile +
        "/mobile/AllItems/" +
        TheUser[0]['admin_id'].toString() +
        '/' +
        TheUser[0]['branch'].toString()));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "The are No items") {
        await EasyLoading.showError(json[0]);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MmodifyBook()));
      } else {
        await EasyLoading.showSuccess("The Items are here");
        AllItems.clear();
        AllItems.addAll(json);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ListItems()));
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  // Add book method
  static MobileAddbook(Titlee, Author, Genre, Publisher, Date, Loc, Description,
      ImageUrl, rfid_flag, context) async {
    http.Response response = await _client.post(
        MobileAddBook +
            TheUser[0]['admin_id'].toString() +
            '/' +
            TheUser[0]['rfid'].toString() +
            '/' +
            TheUser[0]['branch'].toString(),
        body: {
          "Title": Titlee,
          "Author": Author,
          "Genre": Genre,
          "Publisher": Publisher,
          "Date": Date,
          "Loc": Loc,
          "Description": Description,
          "ImageUrl": ImageUrl,
          "rfid_flag": rfid_flag,
          "rfid_value": '0',
        });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "done") {
        await EasyLoading.showSuccess("Book added successfully");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const hmpage_op()));
      } else {
        await EasyLoading.showError(json[0]);
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }

  // Remove book method
  static MobileRemoveBook(book_title, book_author, rfid_flag, context) async {
    http.Response response = await _client.post(
        MobileRmBook +
            TheUser[0]['admin_id'].toString() +
            '/' +
            TheUser[0]['branch'].toString(),
        body: {
          "title": book_title,
          "author": book_author,
          "rfid_flag": rfid_flag
        });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == "done") {
        await EasyLoading.showSuccess("Book removed successfully");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MmodifyBook()));
      } else {
        await EasyLoading.showError("The Book is not in the database");
      }
    } else {
      EasyLoading.showError("Error code : ${response.statusCode.toString()}");
    }
  }

  // Remove book NFC
  static MobileRemoveItemNFC(context) async {
    if (res == 0) {
      await EasyLoading.showSuccess("The Item has not been scanned");
    } else {
      http.Response response = await _client.get(
        MobileRmBookNFC +
            TheUser[0]['admin_id'].toString() +
            '/' +
            TheUser[0]['branch'].toString() +
            '/' +
            res.toString(),
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json[0] == "done") {
          await EasyLoading.showSuccess("Book removed successfully");
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MmodifyBook()));
        } else {
          Navigator.pop(context);
          await EasyLoading.showError("The Book is not in the database");
        }
      } else {
        EasyLoading.showError("Error code : ${response.statusCode.toString()}");
      }
    }
  }

  // Add Item with NFC
  static MobileAddItemNFC(Titlee, Author, Genre, Publisher, Date, Loc,
      Description, ImageUrl, rfid_flag, context) async {
    if (res == 0) {
      await EasyLoading.showSuccess("The Item has not been scanned");
    } else {
      http.Response response = await _client.get(MobileAddItemCheckurl +
          TheUser[0]['admin_id'].toString() +
          '/' +
          TheUser[0]['branch'].toString() +
          '/' +
          res.toString());
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json[0] == "not found") {
          await EasyLoading.showSuccess("RFID is new");
          http.Response response1 = await _client.post(
              MobileAddBook +
                  TheUser[0]['admin_id'].toString() +
                  '/' +
                  TheUser[0]['rfid'].toString() +
                  '/' +
                  TheUser[0]['branch'].toString(),
              body: {
                "Title": Titlee,
                "Author": Author,
                "Genre": Genre,
                "Publisher": Publisher,
                "Date": Date,
                "Loc": Loc,
                "Description": Description,
                "ImageUrl": ImageUrl,
                "rfid_flag": rfid_flag,
                "rfid_value": res.toString(),
              });
          if (response1.statusCode == 200) {
            await EasyLoading.showSuccess(
                "The Item has been registered successfully");
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MmodifyBook()));
          } else {
            EasyLoading.showError(
                "Error Code : ${response.statusCode.toString()}");
          }
        } else {
          await EasyLoading.showError(json[0]);
          Navigator.pop(context);
        }
      } else {
        EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
      }
    }
  }
}
