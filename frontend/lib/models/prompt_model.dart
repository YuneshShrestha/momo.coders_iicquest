class PromptModel {
    PromptModel({
        required this.answers,
    });

    final List<String> answers;

    factory PromptModel.fromJson(Map<String, dynamic> json){ 
        return PromptModel(
            answers: json["answers"] == null ? [] : List<String>.from(json["answers"]!.map((x) => x)),
        );
    }

}
