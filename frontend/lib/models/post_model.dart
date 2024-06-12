class PostModel {
    PostModel({
        required this.id,
        required this.title,
        required this.description,
        required this.userId,
        required this.createdAt,
        required this.updataedAt,
    });

    final String? id;
    final String? title;
    final String? description;
    final String? userId;
    final DateTime? createdAt;
    final DateTime? updataedAt;

    factory PostModel.fromJson(Map<String, dynamic> json){ 
        return PostModel(
            id: json["id"],
            title: json["title"],
            description: json["description"],
            userId: json["userId"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updataedAt: DateTime.tryParse(json["updataedAt"] ?? ""),
        );
    }

}
