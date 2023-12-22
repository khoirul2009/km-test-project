import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:km_test/models/user_model.dart';

class UserRepository {
  final String _baseUrl = "https://reqres.in/api/users";

  Future<List<UserModel>> getUser(int page, int limit) async {
    final response =
        await http.get(Uri.parse("$_baseUrl?page=$page&per_page=$limit"));
    final data = json.decode(response.body)['data'];
    return List<UserModel>.from(data.map((e) => UserModel.fromJson(e)));
  }
}
