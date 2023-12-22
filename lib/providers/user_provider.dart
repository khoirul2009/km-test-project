import 'package:flutter/foundation.dart';
import 'package:km_test/models/user_model.dart';

import '../repositories/user_repositories.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  final int _limit = 10;
  int _page = 1;
  bool hasMore = true;
  List<UserModel> users = [];
  bool isLoading = false;

  Future fetchUser() async {
    try {
      isLoading = true;
      List<UserModel> response = await _userRepository.getUser(_page, _limit);

      if (response.length < _limit) {
        hasMore = false;
      }

      users.addAll(response);

      _page++;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }

  Future refresh() async {
    _page = 1;
    users = [];
    hasMore = true;
    await fetchUser();
    notifyListeners();
  }
}
