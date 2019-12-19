import Foundation

final class ContentViewModel : ObservableObject {
    
    var questions = [
    ("Das Videospiel Donkey Kong sollte ursprünglich Popeye als Hauptfigur haben.", true),
    ("Die Farbe Orange wurde nach der Frucht benannt.", true),
    ("In der griechischen Mythologie ist Hera die Göttin der Ernte.", false),
    ("Liechtenstein hat keinen eigenen Flughafen.", true),
    ("Die meisten Subarus werden in China hergestellt.", false)]
    
    @Published var index = 0 {
        didSet {
            question = questions[index].0
        }
    }    
    @Published var question = ""
    @Published var answer = "XXXXXXXXXX"
    @Published var resultOpacity = 0.0

    var correctAnswers = 0
    var wrongAnswers = 0
    var skippedQuestions = 0
    var questionsSeen: Int {
        return correctAnswers + wrongAnswers + skippedQuestions
    }
    
    init() {
        question = questions[index].0
    }
    
    func skipQuestion() {
        nextQuestion()
        skippedQuestions += 1
    }
    
    func nextQuestion() {
        index = (index + 1) % questions.count
        resultOpacity = 0.0
    }
    
    func sendTrueAsAnswer() {
        evaluateAnswer(answer: true)
    }
    
    func sendFalseAsAnswer() {
        evaluateAnswer(answer: false)
    }
    
    func evaluateAnswer(answer: Bool) {
        resultOpacity = 1.0
        if (questions[index].1 == answer) {
            self.answer = "Richtig!"
            correctAnswers += 1
        } else {
            self.answer = "Falsch!"
            wrongAnswers += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            self.nextQuestion()
        }
        
    }
}

