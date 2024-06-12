class CategoryModel {
    CategoryModel({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.updataedAt,
    });

    final String? id;
    final String? name;
    final DateTime? createdAt;
    final DateTime? updataedAt;

    factory CategoryModel.fromJson(Map<String, dynamic> json){ 
        return CategoryModel(
            id: json["id"],
            name: json["name"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updataedAt: DateTime.tryParse(json["updataedAt"] ?? ""),
        );
    }

}
