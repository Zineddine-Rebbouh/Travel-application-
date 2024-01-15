import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:travel_app/widgets/PostList.dart';
import 'package:travel_app/widgets/distance.dart';

class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({
    required this.post,
  });
  final Post post;

  @override
  Widget build(BuildContext context) {
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
                        image: AssetImage(post.placeImage ?? ''),
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
                            onPressed: () {},
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
                      post.name ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      post.location ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: IconButton(
                    onPressed: () {},
                    iconSize: 20,
                    icon: const Icon(Ionicons.chatbubble_ellipses_outline),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      post.star ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Icon(
                      Ionicons.star,
                      color: Colors.yellow[800],
                      size: 15,
                    )
                  ],
                )
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
                    Text(
                      "01d:32h:56m",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Started in",
                      style: Theme.of(context).textTheme.bodySmall,
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
                  image: AssetImage('assets/map.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Distance(),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                Text(
                  post.about ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
