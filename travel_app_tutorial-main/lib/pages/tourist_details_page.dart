import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/config/config.dart';
import 'package:travel_app/provider/provider.dart';
import 'package:travel_app/widgets/PostList.dart';
import 'package:travel_app/widgets/distance.dart';
import 'package:http/http.dart' as http;

class TouristDetailsPage extends StatelessWidget {
  const TouristDetailsPage({
    Key? key,
    required this.post, // Change the parameter to take a Post object
  }) : super(key: key);

  final Post post; // Update the type to be Post

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    String userId = userProvider.user?.id ?? '';
    void addFavourite() async {
      print(post.id);
      try {
        final response = await http.get(
          Uri.parse(
              '${AppConfig().baseUrl}/post/add-favourites/${userId}/${post.id}'),
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

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            SizedBox(
              height: size.height * 0.38,
              width: double.maxFinite,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20)),
                      image: DecorationImage(
                        // Use Image.network for loading images from a network URL
                        image: NetworkImage(_getImage(post.placeImage)),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(15)),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            iconSize: 20,
                            icon: const Icon(Ionicons.chevron_back),
                          ),
                          IconButton(
                            iconSize: 20,
                            onPressed: () {
                              addFavourite();
                            },
                            icon: const Icon(Ionicons.heart_outline),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.name ??
                          '', // Use post.name instead of hardcoded text
                      style: Theme.of(context).textTheme.titleLarge,
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
                          '${post.location} , Algeria',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Ionicons.star,
                      color: Colors.yellow[800],
                      size: 15,
                    ),
                    Icon(
                      Ionicons.star,
                      color: Colors.yellow[800],
                      size: 15,
                    ),
                    Icon(
                      Ionicons.star,
                      color: Colors.yellow[800],
                      size: 15,
                    ),
                    Icon(
                      Ionicons.star,
                      color: Colors.yellow[800],
                      size: 15,
                    ),
                    Icon(
                      Ionicons.star,
                      color: Colors.yellow[800],
                      size: 15,
                    ),
                    Text(
                      post.star
                          .toString(), // Use post.rating instead of hardcoded text
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      "Location",
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 180,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                image: DecorationImage(
                  // Use post.mapImage instead of a hardcoded image path
                  image: AssetImage('assets/map.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Distance(),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the start
              children: [
                Text(
                  "About",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                Text(
                  post.about ??
                      '', // Use post.description instead of hardcoded text
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String _getImage(String? image) {
    if (image != null) {
      if (image.startsWith('http')) {
        print(image);
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
