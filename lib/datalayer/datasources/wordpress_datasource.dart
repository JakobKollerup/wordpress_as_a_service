import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wordpress_as_a_service/datalayer/models/wordpress/post_model.dart';
import 'package:wordpress_as_a_service/domainlayer/entities/wordpress/post_entity.dart';

abstract class WordpressDataSource {
  Future<List<PostEntity>> getPosts();
  // Wordpress methods
}

class WordpressDataSourceImpl implements WordpressDataSource {
  final http.Client client;
  // I am using a local docker instance of wordpress, i will link to my docker setup in the documentation
  var baseUrl = "http://localhost:8000/wp-json/wp/v2";

  WordpressDataSourceImpl({required this.client});

  @override
  Future<List<PostEntity>> getPosts() async {
    List<PostEntity> posts = [];
    // takes  the baseUrl and adds the endpoint
    // We need to use _embed because we need to get image url
    var useUrl = "$baseUrl/posts?_embed";
    try {
      var res = await client.get(
        // this uri can be used insted to retrive id, title, content, featured_links
        // "/wp-json/wp/v2/posts?_fields=id,title,content,featured_media,_links,_embedded&_embed"
        // We need to use _embed because we need to get image url
        Uri.parse(useUrl),
        headers: {
          'content-type': 'application/json ',
        },
      );
      print(res.statusCode.toString());
      if (res.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(res.body);
        for (var json in jsonList) {
          PostEntity post = PostModel.fromJson(json);
          posts.add(post);
        }
      }
    } catch (e) {}
    return posts;
  }
}
