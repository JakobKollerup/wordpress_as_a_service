import 'package:equatable/equatable.dart';
import 'package:wordpress_as_a_service/domainlayer/entities/wordpress/post_entity.dart';

class PostModel extends PostEntity with EquatableMixin {
  int? id;
  String? title;
  String? content;
  String? imageUrl;
  String? author;

  PostModel(this.id, this.title, this.content, this.imageUrl, this.author)
      : super(
          id: id,
          title: title,
          content: content,
          imageUrl: imageUrl,
          author: author,
        );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      // Mapping
      json["id"],
      json['title']?['rendered'],
      json['content']?['rendered']
          .toString()
          .replaceAll("<p>", "")
          .replaceAll("</p>", "")
          .replaceAll("<br />", "\n"), // We are removing some css formatting

      // Here we use a ternary operator and a null coalescing operator, so if there is no featuremedia image we sets it too default
      json["_embedded"]["wp:featuredmedia"] != null && json["_embedded"]["wp:featuredmedia"].isNotEmpty
          ? json["_embedded"]["wp:featuredmedia"][0]["source_url"] ?? ""
          : "https://img.freepik.com/free-photo/triumphing-happy-guy-raises-clenched-fist-celebrates-winning-lottery-gets-message-confirming-holds-mobile-phone-browses-social-media-wears-yellow-hat-striped-jumper-always-stays-touch_273609-31312.jpg?size=626&ext=jpg",
      json["_embedded"]["author"][0]["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'imageUrl': imageUrl,
        'author': author,
      };

  @override
  // Equatable to compare
  List<Object?> get props => [id, title, content, imageUrl];
}
