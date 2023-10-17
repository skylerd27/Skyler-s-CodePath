import SwiftUI

struct TriviaView: View {
    @StateObject var viewModel = ViewModel_Trivia()

    var body: some View {
        Group {
            if viewModel.isQuizComplete {
                ResultsView(correctAnswers: viewModel.correctAnswerCount) {
                    viewModel.fetchQuestions()
                }
                .background(Color.yellow)
            } else if !viewModel.questions.isEmpty {
                VStack(spacing: 20) {
                    Text("Question \(viewModel.currentQuestion + 1) of \(viewModel.questions.count)")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .padding(.top, 40)  // Adding padding to avoid notch

                    Text(viewModel.questions[viewModel.currentQuestion].question.htmlDecoded)
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                        .foregroundColor(.white)

                    ForEach(0..<viewModel.questions[viewModel.currentQuestion].allAnswers.count, id: \.self) { index in
                        AnswerButton(text: viewModel.questions[viewModel.currentQuestion].allAnswers[index].htmlDecoded) {
                            viewModel.answerQuestion(with: index)
                        }
                    }

                    Spacer()
                }
                .background(Color.yellow)
                .edgesIgnoringSafeArea(.all)
            } else {
                Text("Loading...")
            }
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
    let restartAction: () -> Void

    var body: some View {
        VStack {
            Text("Quiz Completed!")
                .font(.largeTitle)
                .padding()

            Text("You got \(correctAnswers) correct answers!")
                .font(.headline)
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

