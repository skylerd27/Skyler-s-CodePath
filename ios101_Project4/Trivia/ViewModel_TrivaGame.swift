import Foundation

class ViewModel_Trivia: ObservableObject {
    @Published var currentQuestion: Int = 0
    @Published var questions: [TriviaQuestion] = []
    @Published var isQuizComplete: Bool = false
    @Published var correctAnswerCount: Int = 0

    private var service = TriviaQuestionService()

    init() {
        fetchQuestions()
    }

    func fetchQuestions() {
        service.fetchTriviaQuestions { [weak self] fetchedQuestions in
            DispatchQueue.main.async {
                self?.questions = fetchedQuestions ?? []
                self?.currentQuestion = 0
                self?.correctAnswerCount = 0
                self?.isQuizComplete = false
            }
        }
    }

    func answerQuestion(with index: Int) {
        if questions[currentQuestion].allAnswers[index] == questions[currentQuestion].correctAnswer {
            correctAnswerCount += 1
        }
        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
        } else {
            isQuizComplete = true
        }
    }
    
    var currentTriviaQuestion: TriviaQuestion? {
        if currentQuestion >= 0 && currentQuestion < questions.count {
            return questions[currentQuestion]
        }
        return nil
    }
}

