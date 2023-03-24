import 'package:wordpress_as_a_service/datalayer/datasources/wordpress_datasource.dart';
import 'package:wordpress_as_a_service/domainlayer/entities/wordpress/post_entity.dart';
import 'package:wordpress_as_a_service/domainlayer/repositories/wordpress_repository.dart';

class WordpressRepositoryImpl implements WordpressRepository {
  final WordpressDataSource wordpressDataSource;

  WordpressRepositoryImpl({required this.wordpressDataSource});

  @override
  Future<List<PostEntity>> getPosts() => wordpressDataSource.getPosts();
}
