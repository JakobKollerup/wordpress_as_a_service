import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wordpress_as_a_service/domainlayer/entities/wordpress/post_entity.dart';
import 'package:wordpress_as_a_service/domainlayer/usecases/wordpress/get_all_posts.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final GetPostsUseCase getPostsUseCase;
  PostCubit({required this.getPostsUseCase}) : super(const PostStateInitial());

  Future<void> getPosts() async {
    try {
      var posts = await getPostsUseCase.getPosts();
      emit(PostStateLoaded(posts: posts));
    } on SocketException catch (_) {
      emit(PostStateFailure());
    } catch (e) {
      emit(PostStateFailure());
    }
  }
}
