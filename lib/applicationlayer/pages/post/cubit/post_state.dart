part of 'post_cubit.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostStateInitial extends PostState {
  const PostStateInitial();
}

class PostStateLoading extends PostState {
  const PostStateLoading();
}

class PostStateLoaded extends PostState {
  final List<PostEntity> posts;
  const PostStateLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}

class PostStateFailure extends PostState {
  const PostStateFailure();
}
