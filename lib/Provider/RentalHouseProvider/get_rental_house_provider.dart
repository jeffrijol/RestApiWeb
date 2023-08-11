import 'dart:convert';

import 'package:rest_api_app/Constants/url.dart';
import 'package:rest_api_app/Provider/Database/db_provider.dart';
import 'package:http/http.dart' as http;

import '../../Model/rental_house_model.dart';

class GetRentalHouse {
  final url = AppUrl.baseUrl;

  Future<List<RentalHouseModel>> getRentalHouse() async {
    final userId = await DatabaseProvider().getUserId();
    final token = await DatabaseProvider().getToken();

       
    String _url = "$url/rentalHouse/user/$userId";

    try {
      final response = await http
          .get(Uri.parse(_url), headers: {'Authorization': 'Bearer $token'});

    

      if (response.statusCode == 200 || response.statusCode == 201) {
        //TODO falta validar si no hay rental house que mostrar
        //return RentalHouseModel.fromJson(json.decode(response.body));
        return List.from(json.decode(response.body)).map((e)=>RentalHouseModel.fromJson(e)).toList();
      } else {
        print(response.body);
        // final notificationModel = notificationModelFromJson(request.body);

        return Future.error(response.statusCode);
      }
    } catch (e) {
      print(e);
      return Future.error(e.toString());
    }
  }
}
