import 'package:flutter/material.dart';
import 'package:wordpress_as_a_service/applicationlayer/pages/post/detailed_post.dart';
import 'package:wordpress_as_a_service/di_container.dart' as di;
import 'package:wordpress_as_a_service/domainlayer/entities/wordpress/post_entity.dart';
import 'package:wordpress_as_a_service/domainlayer/usecases/wordpress/get_all_posts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<PostEntity>> getAllPosts() async {
    var posts = await di.sl<GetPostsUseCase>().getPosts();
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Wordpress as a service"),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // H1
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text("All WP Posts", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            // Get Posts
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: FutureBuilder<List<PostEntity>>(
                future: getAllPosts(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Text("There is no WP Posts to show");
                  } else {
                    List<PostEntity> posts = snapshot.data!;
                    return SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          PostEntity post = posts[index];
                          // Text for short description

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SinglePostView(
                                            post: snapshot.data![index],
                                          )));
                            },
                            child: Padding(
                              padding:
                                  // We use ternary operator to differentiate the left and right padding if it is index 0 or not
                                  index == posts.length - 1 ? const EdgeInsets.only(right: 16.0, left: 8) : const EdgeInsets.only(right: 0, left: 16),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                width: 220,
                                decoration: const BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${post.title}",
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    const SizedBox(height: 5),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        "${post.imageUrl}",
                                        height: 150,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "${post.content!.substring(0, 70)}\n\n...Read more",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ));
  }
}
