import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:travel_app/config/config.dart';
import 'package:travel_app/pages/tourist_details_page.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/widgets/PostList.dart';
import 'dart:math';

class RecommendedPlaces extends StatefulWidget {
  const RecommendedPlaces({Key? key}) : super(key: key);

  @override
  _RecommendedPlacesState createState() => _RecommendedPlacesState();
}

class _RecommendedPlacesState extends State<RecommendedPlaces> {
  late List<Post> postList;
  Future<List<Post>> emptyFuture = Future.value(List<Post>.empty());

  Future<List<Post>> getPosts() async {
    try {
      final response = await http.get(
        Uri.parse('${AppConfig().baseUrl}/post/get-posts'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['posts'];
        List<Post> posts = data.map((post) => Post.fromJson(post)).toList();
        // Removed unnecessary setState() as it's not needed for postList
        postList = posts;

        print(postList);
        print('Posts fetched successfully');

        return postList;
      } else {
        print('Failed to load posts. Status code: ${response.statusCode}');
        throw Exception('Failed to load posts');
      }
    } catch (error) {
      print('Error fetching posts: $error');
      throw Exception('Error fetching posts');
    }
  }

  @override
  void initState() {
    super.initState();
    // Call getPosts() only once in initState to fetch the data
    emptyFuture = getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: emptyFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No data available');
        } else {
          return SizedBox(
            height: 235,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return buildRecommendedPlaceCard(snapshot.data![index]);
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(width: 10), // Adjust the spacing here
              itemCount: min(2, snapshot.data!.length),
            ),
          );
        }
      },
    );
  }

  Widget buildRecommendedPlaceCard(Post place) {
    return SizedBox(
      width: 220,
      child: Card(
        elevation: 0.4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TouristDetailsPage(
                  post: place,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    _getImage(place.placeImage),
                    height: 150,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      place.name ?? '',
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade700,
                      size: 14,
                    ),
                    Text(
                      place.star.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Ionicons.location,
                      color: Color.fromARGB(255, 255, 137, 26),
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${place.location} , Algeria',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getImage(String? image) {
    if (image != null) {
      if (image.startsWith('http')) {
        return image;
      } else {
        return '${AppConfig().baseUrl}/$image';
      }
    } else {
      return 'assets/aizen.jpeg';
    }
  }
}
