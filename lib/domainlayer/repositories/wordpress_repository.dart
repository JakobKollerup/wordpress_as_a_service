import 'package:wordpress_as_a_service/domainlayer/entities/wordpress/post_entity.dart';

abstract class WordpressRepository {
  Future<List<PostEntity>> getPosts();
}
