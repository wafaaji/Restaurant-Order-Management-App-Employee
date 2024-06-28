import 'dart:convert';
import 'package:employee/config/serverConfig.dart';
import 'package:employee/model/deleteMainMealDrinkModel.dart';
import 'package:employee/native-services/secureStorage.dart';
import 'package:http/http.dart' as http;

class DeleteMainMealService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.deleteMeal);

  Future<bool> deleteMainMeal(DeleteMainMealDrink deleteMainMealDrink) async{

    SecureStorage storage = SecureStorage();
    var token = await storage.read("token");

    var response = await http.post(
      url,
      headers: {
        "Authorization" : "Bearer $token"
      },
      body: {
        "meal_id" : "${deleteMainMealDrink.id}",
      },
    );

    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      message = "delete success";
      return true;
    }else if (response.statusCode == 400){
      var jsonResponse = jsonDecode(response.body);
      message = jsonResponse["meal_id"];
      return false;
    }else{
      message = 'Server Error';
      return false;
    }

  }

}