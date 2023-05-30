
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/OrdersModel.dart';


String patasente_base_url = "https://patasente.me";
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

}