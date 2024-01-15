import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travel_app/config/config.dart';
import 'package:travel_app/pages/login.dart';
import 'package:travel_app/widgets/PostList.dart';
import 'package:travel_app/widgets/UserList.dart';
import 'package:http/http.dart' as http;

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int _currentIndex = 0;

  // List of pages corresponding to each icon
  final List<Widget> _pages = [
    ProfilePageScreen(),
    UserList(),
    PostList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Admin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Navigate to Profile Page
                setState(() {
                  _currentIndex = 0;
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            // Top Links
            ListTile(
              leading: Icon(Icons.people),
              title: Text('User List'),
              onTap: () {
                // Navigate to User List page
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.article),
              title: Text('Post List'),
              onTap: () {
                // Navigate to Post List page
                setState(() {
                  _currentIndex = 2;
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            Divider(), // Add a divider for visual separation
            // Bottom Links
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Perform logout actions
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                ); // Close the drawer
                // Add your logout logic here
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help'),
              onTap: () {
                // Navigate to Help page
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/help');
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
    );
  }
}

class ProfilePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        // Add a back arrow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Center(child: Text('Profile Page')),
    );
  }
}

class PostListScreen extends StatelessWidget {
  Future<List<Post>> getPosts() async {
    final response =
        await http.get(Uri.parse('${AppConfig().baseUrl}/post/get-posts'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['posts'];
      print(data);
      List<Post> posts = data.map((post) => Post.fromJson(post)).toList();
      print('1');
      print(posts);
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post List'),
      ),
      body: FutureBuilder<List<Post>>(
        future: getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No posts found.'),
            );
          } else {
            List<Post> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                Post post = posts[index];
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/aizen.jpeg')),
                  title: Text(post.name!),
                  subtitle: Text(post.location!),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Delete post functionality
                      deletePost(post.id!);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
// Add your deletePost function here
}

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> userList = [];

  Future<List<User>> getUsers() async {
    final response =
        await http.get(Uri.parse('${AppConfig().baseUrl}/user/all-users'));
    if (response.statusCode == 200) {
      return (json.decode(response.body)['users'] as List)
          .map((user) => User.fromJson(user))
          .toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    List<User> users = await getUsers();
    setState(() {
      userList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: FutureBuilder<List<User>>(
        future: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No users found.');
          } else {
            List<User> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                User user = users[index];
                if (!userList.contains(user)) {
                  userList.add(user);
                }
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: _getImage(user.profilePic) ??
                        AssetImage('assets/default_image.jpeg'),
                  ),
                  title: Text(user.username),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Delete user functionality
                      deleteUser(user.id);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  ImageProvider<Object>? _getImage(String? image) {
    if (image != null && image.isNotEmpty) {
      return NetworkImage(
          '${AppConfig().baseUrl}/' + image.replaceFirst(r'\\', '/'));
    } else {
      return null;
    }
  }
}

void deleteUser(String userId) {
  // Implement your logic to delete a user
}
void deletePost(String postId) {
  // Implement your logic to delete a post
}
