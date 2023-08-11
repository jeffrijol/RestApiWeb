import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rest_api_app/Constants/url.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_app/Provider/Database/db_provider.dart';
import 'package:rest_api_app/Screens/Authentication/login.dart';
import 'package:rest_api_app/Screens/TaskPage/home_page.dart';
import 'package:rest_api_app/Utils/routers.dart';

class AuthenticationProvider extends ChangeNotifier {
  ///Base Url
  final requestBaseUrl = AppUrl.baseUrl;

  ///Setter
  bool _isLoading = false;
  String _resMessage = '';

  //Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/singin/";

    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "pass": password
    };
    print(body);

    try {
      http.Response req =
          await http.post(Uri.parse(url), body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        _isLoading = false;
        _resMessage = "Account created!";
        notifyListeners();
        PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
      } else {
        final res = json.decode(req.body);

        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  //Login
  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/singin";

    final body = {"email": email, "pass": password};

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(body),
      );
      print(response.statusCode);
      

      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = json.decode(response.body);

        print(res);
        _isLoading = false;
        _resMessage = "Login successfull!";
        notifyListeners();

        ///Save users data and then navigate to homepage
        final userId = res['user']['_id'];
        final token = res['token'];
        DatabaseProvider().saveToken(token);
        DatabaseProvider().saveUserId(userId);
        PageNavigator(ctx: context).nextPageOnly(page: const HomePage());
      } else {
        final res = json.decode(response.body);

        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
