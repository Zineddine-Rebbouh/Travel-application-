import 'package:flutter/material.dart';
import 'package:travel_app/config/config.dart';
import 'package:travel_app/models/recommended_places_model.dart';
import 'package:travel_app/widgets/post_detailed_page.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                _getImage(post.placeImage),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.name ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 20,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text('${post.location} , Algeria' ?? '')
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        post.star.toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Click on for more informations',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
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
