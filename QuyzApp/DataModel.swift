struct ApiResponse: Codable {
    struct QuizObject: Codable {
        var question: String?
        var correct_answer: String?
    }
    var results: [QuizObject]
}
