
import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/OrdersModel.dart';


String patasente_base_url = "https://patasente.me";
var db = FirebaseFirestore.instance;
class userManagement{

  //LOGIN
  Future<String> login(username,password) async{
    Map body = {
      'username': username,
      'password': password
    };
    var response = await http.post(
        Uri.parse("$patasente_base_url/phantom-api/login"),
        headers: {
          // "Accept": "application/json",
          //  'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body
    );
//    var data = convert.jsonDecode(response.body)["markets"];
//    return data;
//    print(response.body);
    return response.body;
  }

  Future<String> getUserDetails(token) async{
    var response = await http.get(
//      Uri.encodeFull("$_baseUrl/admin/user/"+id),
      Uri.parse("$patasente_base_url/phantom-api/get-company-details"),
      headers: {
        "Accept": "application/json",
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    return response.body;
  }
}

class dataManagement{

  //GET ORDERS
  static Future<List<OrdersModel>?> getOrdersNew() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = jsonDecode(prefs.getString("user")!)["token"];
    // print(token);
    var response = await http.get(
      Uri.parse(Uri.encodeFull("$patasente_base_url/phantom-api/get-all-my-purchase-order/order?take=100")),
      headers: {
        "Accept": "application/json",
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    if(response.statusCode == 200){
      var dataString = response.body;
      return orderFromJson(dataString);
    }else{
      return null;
    }
  }

  configureQR(code,serial) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = jsonDecode(prefs.getString("user")!);
    var name = userData["userDetails"]["business_name"];
    var phone = userData["userDetails"]["user_phone_number"];
    var email = userData["userDetails"]["business_email"];

    final codes = <String, dynamic>{
      "name": name,
      "phone": phone,
      "email": email,
      "code": code,
      "serial": serial,
      "verified": false,
    };
    print("USER::: $codes");
    // Create a reference to the cities collection
    final codesRef = db.collection("codes");

// Create a query against the collection.
    QuerySnapshot querySnapshot = await codesRef.where("code", isEqualTo: "$code").get();
    /*for (var docSnapshot in querySnapshot.docs) {
      print('${docSnapshot.id} => ${docSnapshot.data()}');
      var data = docSnapshot.data();
      if(data["code"])
    }*/


    print(querySnapshot.docs);

        if (querySnapshot.docs.length>0) {
          return null;
        } else {
          var doSave = await codesRef.add(codes);
          return doSave;
        }
  }

  checkQR(code) async{
    final codesRef = db.collection("codes");

// Create a query against the collection.
    QuerySnapshot querySnapshot = await codesRef.where("code", isEqualTo: "$code").get();

    print(querySnapshot.docs);

        if (querySnapshot.docs.length>0) {
          await codesRef.doc(querySnapshot.docs[0].id).update({
            "verified": true,
          });
          return querySnapshot.docs[0];
        } else {
          return null;
        }
  }
}