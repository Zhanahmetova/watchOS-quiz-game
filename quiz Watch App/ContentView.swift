import SwiftUI

struct ContentView: View {
    
    @State var currentQuestionIndex = 0
    @State var score = 0
    
    let questions = [
        Question(question: "What is the capital of France?", options: ["A. Paris", "B. Rome", "C. Madrid"], correctAnswerIndex: 0),
        Question(question: "What is the largest mammal on Earth?", options: ["A. Elephant", "B. Blue Whale", "C. Giraffe"], correctAnswerIndex: 1),
        Question(question: "What is the chemical symbol for gold?", options: ["A. Au", "B. Ag", "C. Cu"], correctAnswerIndex: 0),
        Question(question: "What is the tallest mountain in the world?", options: ["A. Mount Everest", "B. Mount Kilimanjaro", "C. Mount Fuji"], correctAnswerIndex: 0),
    ]
    
    private var isQuizComplete: Binding<Bool> {
        Binding<Bool>(get: {
            return currentQuestionIndex >= questions.count
        }, set: { _ in })
    }

    
    var body: some View {
        VStack {
            if currentQuestionIndex < questions.count {
                Text(questions[currentQuestionIndex].question)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                
                ForEach(0..<questions[currentQuestionIndex].options.count) { index in
                    Button(action: {
                        checkAnswer(selectedAnswerIndex: index)
                    }) {
                        Text(questions[currentQuestionIndex].options[index])
                            .font(.body)
                            .fontWeight(.regular)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                
                Spacer()
            }
        }
        .padding(EdgeInsets(top: 45, leading: 4, bottom: 20, trailing: 4))
        .alert(isPresented: isQuizComplete) {
            Alert(title: Text("Quiz Complete"), message: Text("Your score is \(score)/\(questions.count)"), dismissButton: .default(Text("OK")) {
                resetQuiz()
            })
        }
    }
    
    func checkAnswer(selectedAnswerIndex: Int) {
        if selectedAnswerIndex == questions[currentQuestionIndex].correctAnswerIndex {
            score += 1
        }
        currentQuestionIndex += 1
    }
    
    func resetQuiz() {
        currentQuestionIndex = 0
        score = 0
    }
}

struct Question {
    let question: String
    let options: [String]
    let correctAnswerIndex: Int
}

