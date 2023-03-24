import 'package:flutter/material.dart';
import 'package:wordpress_as_a_service/domainlayer/entities/wordpress/post_entity.dart';

class SinglePostView extends StatelessWidget {
  final PostEntity post;

  const SinglePostView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${post.title}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              post.content!,
              style: TextStyle(),
              textAlign: TextAlign.left,
            ),
            Image.network(
              "${post.imageUrl}",
              width: 200,
            )
          ],
        ),
      ),
    );
  }
}
