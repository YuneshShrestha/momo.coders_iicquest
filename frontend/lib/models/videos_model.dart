class EventsModel {
  EventsModel({
    required this.id,
    required this.url,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? url;
  final String? categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      id: json["id"],
      url: json["url"],
      categoryId: json["categoryId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }
}
