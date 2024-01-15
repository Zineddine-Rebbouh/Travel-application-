import 'package:flutter/material.dart';
import 'package:travel_app/models/recommended_places_model.dart';
import 'package:travel_app/widgets/UserList.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  List<Post> _userPosts = []; // Change this to List<Post>

  List<Post> get userPosts => _userPosts;
  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setUserPosts(List<Post> posts) {
    _userPosts = posts;
    notifyListeners();
  }
}
