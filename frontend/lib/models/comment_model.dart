class CommentModel {
    CommentModel({
        required this.id,
        required this.comment,
        required this.postId,
        required this.userId,
        required this.userType,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final String? comment;
    final String? postId;
    final String? userId;
    final String? userType;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory CommentModel.fromJson(Map<String, dynamic> json){ 
        return CommentModel(
            id: json["id"],
            comment: json["comment"],
            postId: json["postId"],
            userId: json["userId"],
            userType: json["userType"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

}
