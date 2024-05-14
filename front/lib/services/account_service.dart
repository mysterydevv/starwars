import 'dart:convert';
import 'package:flutter_movie/models/user_account.dart';
import 'package:flutter_movie/utils/token_storage.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_movie/models/response.dart';

class AccountService {
    TokenStorage tokenStorage = TokenStorage();
    final String baseUrl = 'http://10.0.2.2:3000';
    Future<void> register(String email, String password) async {
        var response = await http.post(
            Uri.parse('$baseUrl/register'),
            body: jsonEncode({'email': email, 'password': password}),
            headers: {'Content-Type': 'application/json'},
        );
        var responseBody = jsonDecode(response.body);
        var data = Response.fromJson(responseBody);
        if (data.status != 200) {
            throw Exception(data.message);
        }
    }

    Future<void> login(String email, String password) async {
        var response = await http.post(
            Uri.parse('$baseUrl/login'),
            body: jsonEncode({'email': email, 'password': password}),
            headers: {'Content-Type': 'application/json'},
        );
        var responseBody = jsonDecode(response.body);
        var data = Response.fromJson(responseBody);
        if (data.status != 200) {
            throw Exception(data.message);
        }
        var token = data.data;
        await tokenStorage.writeToken(token);
    }

    Future<void> logout() async {
        await tokenStorage.deleteToken();
    }

    Future<UserAccount> getAccount() async {
        var token = await tokenStorage.readToken();
        var response = await http.get(
            Uri.parse('$baseUrl/account'),
            headers: {'Authorization': '$token'},
        );
        var respopnseBody = jsonDecode(response.body);
        var data = Response.fromJson(respopnseBody);
        if (data.status != 200) {
            throw Exception(data.message);
        }
        return UserAccount.fromJson(data.data);
    }
}

