import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/config/config.dart';
import 'package:travel_app/models/recommended_places_model.dart';
import 'package:travel_app/provider/provider.dart';
import 'package:travel_app/widgets/post_card.dart';
import 'package:http/http.dart' as http;

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    String userId = userProvider.user?.id ?? '';

    _postsFuture = getPosts(userId);
  }

  Future<List<Post>> getPosts(String userId) async {
    try {
      // Make an HTTP request to fetch the user's favorite posts
      final response = await http.get(
        Uri.parse('${AppConfig().baseUrl}/user/get-user/$userId'),
      );

      if (response.statusCode == 200) {
        // Parse the response and extract userFavorites
        final List<dynamic> data =
            json.decode(response.body)['user']['favourites'];
        List<Post> userFavorites =
            data.map((post) => Post.fromJson(post)).toList();

        // Access the user's favorite posts from the provider
        UserProvider userProvider =
            Provider.of<UserProvider>(context, listen: false);

        // Update the list of userFavorites in the UserProvider
        userProvider.setUserPosts(userFavorites);

        print('Favorite Posts fetched successfully');
        return userFavorites;
      } else {
        print('Failed to load user data. Status code: ${response.statusCode}');
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      print('Error fetching user data: $error');
      throw Exception('Error fetching user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // align left
        children: [
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Favorites',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16), // add space
          Expanded(
              child: FutureBuilder<List<Post>>(
                  future: _postsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No favorite posts available'));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return PostCard(post: snapshot.data![index]);
                          });
                    }
                  })),
        ],
      ),
    );
  }
}
