
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


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