class PostModel {
  PostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.createdAt,
    required this.updataedAt,
    required this.commentsCount,
  });

  final String? id;
  final String? title;
  final String? description;
  final String? userId;
  final int? commentsCount;
  final DateTime? createdAt;
  final DateTime? updataedAt;

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json["id"],
      title: json["title"],
      commentsCount: json["commentsCount"],
      description: json["description"],
      userId: json["userId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updataedAt: DateTime.tryParse(json["updataedAt"] ?? ""),
    );
  }
}
