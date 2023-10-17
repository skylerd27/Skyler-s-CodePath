import Foundation

struct TriviaQuestion: Identifiable {
    var id: Int
    var category: String
    var question: String
    var correctAnswer: String
    var incorrectAnswers: [String]

    var allAnswers: [String] {
        return [correctAnswer] + incorrectAnswers.shuffled()
    }

    init(id: Int, from apiQuestion: TriviaQuestionService.APIQuestion) {
        self.id = id
        self.category = apiQuestion.category
        self.question = apiQuestion.question
        self.correctAnswer = apiQuestion.correct_answer
        self.incorrectAnswers = apiQuestion.incorrect_answers
    }
}

extension String {
    var htmlDecoded: String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else { return self }
        return attributedString.string
    }
}

