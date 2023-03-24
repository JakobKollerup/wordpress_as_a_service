class PostEntity {
  int? id;
  String? title;
  String? content;
  String? imageUrl;
  String? author;

  PostEntity({
    this.id,
    this.title,
    this.content,
    this.imageUrl,
    this.author,
  });

  @override
  String toString() {
    String toReturn = "${id} - ${title} - ${content} - ${imageUrl} - ${author}";
    return super.toString();
  }
}
