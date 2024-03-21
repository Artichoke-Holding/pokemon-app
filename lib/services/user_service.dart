import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/user.dart';

class UserService {
  Future<List<User>> fetchUsers(int page, int pageSize) async {
    final String data = await rootBundle.loadString('assets/data.json');
    final jsonResult = json.decode(data);
    final List<User> users = (jsonResult['users'] as List)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList();

    // Fix for endIndex exceeding list length
    int startIndex = page * pageSize;
    int endIndex = startIndex + pageSize;
    endIndex = endIndex > users.length ? users.length : endIndex;

    return users.sublist(startIndex, endIndex);
  }
}
