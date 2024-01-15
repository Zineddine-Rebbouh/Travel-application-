import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/config/config.dart';
import 'package:travel_app/pages/tourist_details_page.dart';
import 'package:travel_app/provider/provider.dart';
import 'package:travel_app/widgets/PostList.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class NearbyPlaces extends StatefulWidget {
  @override
  _NearbyPlacesState createState() => _NearbyPlacesState();
}

class _NearbyPlacesState extends State<NearbyPlaces> {
  List<Post> postList = [];

  Future<void> getPosts() async {
    try {
      final response =
          await http.get(Uri.parse('${AppConfig().baseUrl}/post/get-posts'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['posts'];
        List<Post> posts = data.map((post) => Post.fromJson(post)).toList();
        setState(() {
          postList = posts;
        });

        print(postList);
        print('Posts fetched successfully');
      } else {
        print('Failed to load posts. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching posts: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is initialized
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    String userId = userProvider.user?.id ?? '';

    void addFavourite(postId) async {
      try {
        final response = await http.get(
          Uri.parse(
              '${AppConfig().baseUrl}/post/add-favourites/${userId}/${postId}'),
        );

        if (response.statusCode == 200) {
          print(response);
          print('Add favourites succes !');
        } else {
          throw Exception('Failed to fetch users');
        }
      } catch (error) {
        print('Error: $error');
      }
    }

    return Column(
      children: List.generate(postList.length, (index) {
        final place = postList[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            height: 135,
            width: double.maxFinite,
            child: Card(
              elevation: 0.4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TouristDetailsPage(
                        post:
                            place, // Pass the entire Post object instead of just the image
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          _getImage(place.placeImage),
                          height: 130,
                          width: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row with the text and favorite icon
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    place.name ?? '',
                                    softWrap: true,
                                    maxLines: null,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    addFavourite(place.id);
                                    print('Favorite icon tapped!');
                                  },
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors
                                        .red, // Customize the color as needed
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(children: [
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
                              ),
                            ]),
                            const SizedBox(height: 10),
                            const Spacer(),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow.shade700,
                                  size: 14,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow.shade700,
                                  size: 14,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow.shade700,
                                  size: 14,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow.shade700,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "4.5",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                const Spacer(),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
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
}
