import 'package:wordpress_as_a_service/domainlayer/entities/wordpress/post_entity.dart';
import 'package:wordpress_as_a_service/domainlayer/repositories/wordpress_repository.dart';

class GetPostsUseCase {
  final WordpressRepository repository;
  GetPostsUseCase({required this.repository});

  Future<List<PostEntity>> getPosts() async {
    return repository.getPosts();

    // here you can put your bussines logic
  }
}
