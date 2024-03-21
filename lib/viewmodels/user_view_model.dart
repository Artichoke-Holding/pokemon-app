import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/user_service.dart';

class UsersViewModel extends ChangeNotifier {
  final UserService _userService;
  final List<User> _users = [];
  int _currentPage = 0;
  final int _pageSize = 20;
  bool _hasMore = true;
  bool _isLoading = false;

  List<User> get users => _users;
  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;

  UsersViewModel(this._userService);

  Future<void> fetchUsers() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;


    try {
      List<User> fetchedUsers = await _userService.fetchUsers(_currentPage, _pageSize);
      _users.addAll(fetchedUsers);
      _currentPage++;
      _hasMore = fetchedUsers.isNotEmpty;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void fetchUsersIfEmpty() {
    if (users.isEmpty && !isLoading) {
      fetchUsers();
    }
  }
}
