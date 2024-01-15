import 'dart:convert';
import 'package:readmore/readmore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/config/config.dart';
import 'package:ionicons/ionicons.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
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
        print('Posts fetched successfully');
      } else {
        print('Failed to load posts. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching posts: $error');
    }
  }

  void initState() {
    super.initState();
    // Fetch data when the widget is initialized
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post List'),
      ),
      body: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) {
          return buildPostCard(postList[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPostForm();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildPostCard(Post post) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            _getImage(post.placeImage),
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.name ?? '',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Ionicons.location,
                      color: Theme.of(context).primaryColor,
                      size: 23,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${post.location} , Algeria',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text('${post.type ?? ''}'), // Add this line
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Text('${post.star ?? ''} stars'),
                  ],
                ),
                SizedBox(height: 8),
                ReadMoreText(
                  post.about ?? '',
                  trimLines: 1,
                  trimLength: 100,
                  style: TextStyle(color: Colors.black),
                  colorClickableText: Colors.grey,
                  textAlign: TextAlign.justify,
                  trimCollapsedText: '...Read more',
                  trimExpandedText: ' Less',
                ),
              ],
            ),
          ),
        ],
      ),
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

  void _showAddPostForm() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Post'),
          content: AddPostForm(
            addPostCallback: addPost,
          ),
        );
      },
    );
  }

  Future<void> addPost(String postName, String location, String type,
      String imageUrl, int rating, String description) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${AppConfig().baseUrl}/post/add-post'),
    );

    request.fields['name'] = postName;
    request.fields['location'] = location;
    request.fields['type'] = type;
    request.fields['star'] = rating.toString();
    request.fields['about'] = description;

    if (imageUrl.isNotEmpty) {
      var pic = await http.MultipartFile.fromPath('place_image', imageUrl);
      request.files.add(pic);
    }

    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        // Successfully added post, update the UI or perform any other action
        setState(() {
          postList.add(
            Post(
              name: postName,
              location: location,
              placeImage: imageUrl,
              star: rating.toString(),
              about: description,
              type: type,
            ),
          );
        });
      } else {
        // Handle error, you can show a snackbar or display an error message
        print('Failed to add post. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading file: $error');
      // Handle error
    }
  }
}

class Post {
  final String? id;
  final String? name;
  final String? location;
  final String? placeImage;
  final String? star;
  final String? about;
  final String? type;

  Post({
    this.id,
    this.name,
    this.location,
    this.placeImage,
    this.star,
    this.about,
    this.type,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      name: json['name'],
      location: json['location'],
      placeImage: json['place_image'],
      star: json['star']?.toString(),
      about: json['about'],
      type: json['type'],
    );
  }
}

class AddPostForm extends StatefulWidget {
  final Function(String, String, String, String, int, String) addPostCallback;

  const AddPostForm({Key? key, required this.addPostCallback})
      : super(key: key);

  @override
  _AddPostFormState createState() => _AddPostFormState();
}

class _AddPostFormState extends State<AddPostForm> {
  TextEditingController postNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageUrlController.text = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: postNameController,
          decoration: InputDecoration(labelText: 'Post Name'),
        ),
        SizedBox(height: 16),
        TextField(
          controller: locationController,
          decoration: InputDecoration(labelText: 'Location'),
        ),
        SizedBox(height: 16),
        TextField(
          controller: typeController,
          decoration: InputDecoration(labelText: 'Type'),
        ),
        SizedBox(height: 16),
        TextField(
          controller: imageUrlController,
          decoration: InputDecoration(labelText: 'Image URL'),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _pickImage,
          child: Text('Pick Image'),
        ),
        SizedBox(height: 16),
        TextField(
          controller: ratingController,
          decoration: InputDecoration(labelText: 'Rating'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(labelText: 'About'),
          maxLines: 3,
        ),
        SizedBox(height: 14),
        ElevatedButton(
          onPressed: () {
            widget.addPostCallback(
              postNameController.text,
              locationController.text,
              typeController.text,
              imageUrlController.text,
              int.tryParse(ratingController.text) ?? 0,
              descriptionController.text,
            );
            Navigator.pop(context);
          },
          child: Text('Add Post'),
        ),
      ],
    );
  }
}
