import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_app/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(
      String email, String password, String Urlsegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$Urlsegment?key=AIzaSyA-5LACVHqT49w6U_2gnrKg24graWXXFag';
    try {
      final respone = await http.post(
        url,
        body: json.encode(
          {'email': email, 'password': password, 'returnSecureToken': true},
        ),
      );
     // print(json.decode(respone.body));
      final responseData = json.decode(respone.body);
      if(responseData['error']!=null){
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}