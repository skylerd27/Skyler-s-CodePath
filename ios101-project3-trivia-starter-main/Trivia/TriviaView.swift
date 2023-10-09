//
//  TriviaView.swift
//  Trivia
//
//  Created by Skyler Dale on 10/9/23.
//
import SwiftUI

struct TriviaView: View {
    @StateObject var viewModel = ViewModel_Trivia()

    var body: some View {
        if viewModel.isQuizComplete {
            ResultsView(correctAnswers: viewModel.correctAnswersCount, totalQuestions: viewModel.totalQuestions) {
                viewModel.restartQuiz()
            }
        } else {
            VStack(spacing: 20) {
                Text("Question \(viewModel.currentQuestionNumber) of \(viewModel.totalQuestions)")
                    .font(.title2)
                    //.padding(.top)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .padding(.top, 50)

                Text(viewModel.questions[viewModel.currentQuestion].text)
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    .foregroundColor(.white)

                ForEach(0..<4, id: \.self) { index in
                    AnswerButton(text: viewModel.questions[viewModel.currentQuestion].answers[index]) {
                        viewModel.answerQuestion(answerIndex: index)
                    }
                }

                Spacer()
            }
            .padding()
            .background(Color.yellow)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct AnswerButton: View {
    let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding(.horizontal)
    }
}

struct ResultsView: View {
    let correctAnswers: Int
    let totalQuestions: Int
    let restartAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.yellow
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Quiz Completed!")
                    .font(.largeTitle)
                
                Text("You answered \(correctAnswers) out of \(totalQuestions) questions correctly!")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button(action: restartAction) {
                    Text("Restart Quiz")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}


struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
    }
}
