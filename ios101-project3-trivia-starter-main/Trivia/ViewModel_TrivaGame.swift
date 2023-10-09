//
//  ViewModel_TrivaGame.swift
//  Trivia
//
//  Created by Skyler Dale on 10/9/23.
//

import Foundation
import SwiftUI

class ViewModel_Trivia: ObservableObject {
    @Published var currentQuestion: Int = 0
    @Published var questions: [Question] = sampleQuestions
    @Published var correctAnswersCount: Int = 0
    @Published var isQuizComplete: Bool = false

    var currentQuestionNumber: Int {
        currentQuestion + 1
    }

    var totalQuestions: Int {
        questions.count
    }

    func answerQuestion(answerIndex: Int) {
        if questions[currentQuestion].correctAnswers == answerIndex + 1 {
            correctAnswersCount += 1
        }
        nextQuestion()
    }

    func nextQuestion() {
        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
        } else {
            isQuizComplete = true
        }
    }

    func restartQuiz() {
        currentQuestion = 0
        correctAnswersCount = 0
        isQuizComplete = false
    }
}

let sampleQuestions: [Question] = [
    Question(text: "Which English popstar was not in The Beatles?", answers: ["Paul McCartney", "Ringo Starr", "George Harrison", "Eric Clapton"], correctAnswers: 4),
    Question(text: "What year did Apple Computers introduce the Macintosh?", answers: ["2000", "1975", "1980", "1984"], correctAnswers: 4),
    Question(text: "Who was the 35th president of the United States? ", answers: ["Woodrow Wilson", "Ronald Reagan", "John F. Kennedy", "Richard Nixon"], correctAnswers: 3)
]
