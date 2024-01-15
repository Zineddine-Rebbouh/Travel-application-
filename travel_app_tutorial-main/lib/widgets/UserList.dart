import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/config/config.dart';
import 'package:travel_app/pages/Admin.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> userList = [];

  @override
  void initState() {
    super.initState();
    // Fetch user data when the widget is initialized
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final apiUrl = '${AppConfig().baseUrl}/user/all-users';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      print(response.body); // Print the response body for debugging

      if (response.statusCode == 200) {
        final List<dynamic> userJsonList = jsonDecode(response.body)['users'];

        // Map the JSON list to a list of User objects using the factory constructor
        final List<User> fetchedUsers = userJsonList
            .map((userData) => User.fromJson(userData as Map<String, dynamic>))
            .toList();

        print(fetchedUsers);
        // Update the user list
        setState(() {
          userList = fetchedUsers;
        });
      } else {
        throw Exception('Failed to fetch users');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: userList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return UserCard(userList[index]);
              },
            ),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;

  UserCard(this.user);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.grey[200],
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(_getImage(user.profilePic)),
        ),
        title: Text(
          user.username,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${user.email}'),
            // Add more details as needed
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            deleteUser(user.id);
            // Implement delete functionality if needed
            // You can show a confirmation dialog and delete the user
          },
        ),
      ),
    );
  }
}

class User {
  final String id;
  final String username;
  final String email;
  final String? profilePic;
  final List<String> saves;
  final List<String> favourites;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.profilePic,
    required this.saves,
    required this.favourites,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      profilePic: json['profilePic'],
      saves: List<String>.from(json['saves'] ?? []),
      favourites: List<String>.from(json['favourites'] ?? []),
    );
  }
}

void deleteUser(String? id) async {
  final apiUrl = '${AppConfig().baseUrl}/user/delete-user/${id}';

  try {
    final response = await http.delete(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Map the JSON list to a list of User objects using the factory constructor
      print('deleted user succes !');
      // Update the user list
    } else {
      throw Exception('Failed to delete user');
    }
  } catch (error) {
    print('Error: $error');
  }
}

String _getImage(String? image) {
  if (image != null) {
    if (image.startsWith('http')) {
      // If it's an absolute URL, return it directly
      return image;
    } else {
      // If it's a relative URL, prepend the base URL
      return '${AppConfig().baseUrl}/$image';
    }
  } else {
    // Return a default image URL or an empty string
    return 'assets/aizen.jpeg';
  }
}
