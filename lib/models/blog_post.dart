class BlogPost {
  final String title;
  final String content;
  final String category;
  final String author;
  final String date;
  final String readTime;
  final String imageAsset;
  final bool isFeatured;

  BlogPost({
    required this.title,
    required this.content,
    required this.category,
    required this.author,
    required this.date,
    required this.readTime,
    required this.imageAsset,
    this.isFeatured = false,
  });
}
