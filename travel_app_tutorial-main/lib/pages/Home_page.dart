import 'package:flutter/material.dart';
import 'package:travel_app/models/recommended_places_model.dart';
import 'package:travel_app/widgets/location_card.dart';
import 'package:travel_app/widgets/nearby_places.dart';
import 'package:travel_app/widgets/recommended_places.dart';
import 'package:travel_app/widgets/tourist_places.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double selectedRating = 0.0;
  String selectedLocation = '';
  TextEditingController searchController = TextEditingController();
  List<Post> displayedPosts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/aizen.jpeg'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              showSearchDialog();
            },
            child: Icon(Icons.search),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showFilterDialog();
            },
            child: Icon(Icons.filter_list),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(14),
        children: [
          const LocationCard(),
          const SizedBox(height: 20),
          TouristPlaces(
            onTypeSelected: fetchPostsByType,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recommendation",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "View All",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          RecommendedPlaces(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Experience the traditions ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "View All",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          NearbyPlaces(),
          displayedPosts.isEmpty
              ? Center(child: Text('No posts available'))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: displayedPosts.length,
                  itemBuilder: (context, index) {
                    return NearbyPlaces();
                  },
                ),
        ],
      ),
    );
  }

  void filterPosts() {
    // Implement your logic to filter posts
  }

  void showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Posts'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<double>(
                value: selectedRating,
                onChanged: (value) {
                  setState(() {
                    selectedRating = value ?? 0.0;
                  });
                },
                items: [null, 4.0, 4.5, 5.0].map((rating) {
                  return DropdownMenuItem<double>(
                    value: rating,
                    child: Text(
                      rating != null ? rating.toString() : 'Select Rating',
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Minimum Rating'),
              ),
              TextField(
                controller: TextEditingController(text: selectedLocation),
                onChanged: (value) {
                  setState(() {
                    selectedLocation = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Location'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                filterPosts();
                Navigator.pop(context);
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  void showSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Search Posts'),
          content: TextField(
            controller: searchController,
            decoration: InputDecoration(labelText: 'Search'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Search'),
            ),
          ],
        );
      },
    );
  }

  void fetchPostsByType(String type) {
    // Implement logic to fetch posts based on the selected type
    // Update displayedPosts with the fetched posts
    // For example:
    // List<Post> fetchedPosts = yourApiCall(type);
    // setState(() {
    //   displayedPosts = fetchedPosts;
    // });
  }
}
