import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:wordpress_as_a_service/applicationlayer/pages/post/cubit/post_cubit.dart';
import 'package:wordpress_as_a_service/datalayer/datasources/wordpress_datasource.dart';
import 'package:wordpress_as_a_service/datalayer/repositories/wordpress_repository_impl.dart';
import 'package:wordpress_as_a_service/domainlayer/repositories/wordpress_repository.dart';
import 'package:wordpress_as_a_service/domainlayer/usecases/wordpress/get_all_posts.dart';

// sl = Service Locator
final sl = GetIt.I;

Future<void> init() async {
  /* Im gonna use Factory so we get a new instance of the class  */

  // Application Layer
  sl.registerFactory(() => PostCubit(getPostsUseCase: sl()));

  // Domain Layer
  sl.registerLazySingleton(() => GetPostsUseCase(repository: sl.call()));

  // Data Layer
  sl.registerFactory<WordpressRepository>(() => WordpressRepositoryImpl(wordpressDataSource: sl()));
  sl.registerFactory<WordpressDataSource>(() => WordpressDataSourceImpl(client: sl()));

  // Externs Services etc. google analytics/http client
  sl.registerFactory(() => http.Client());
}
