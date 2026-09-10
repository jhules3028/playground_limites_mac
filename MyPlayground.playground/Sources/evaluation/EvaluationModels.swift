import Foundation

enum EvaluationVisual: String {
    case numericalTable
    case graphUndefined
    case graphDifferent
    case graphContinuous
}

struct EvaluationOption: Identifiable, Hashable {
    let id: String
    let text: String
    let incorrectFeedback: String?
}

struct EvaluationQuestion: Identifiable {
    let id: String
    let moduleNumber: Int
    let moduleTitle: String
    let prompt: String
    let options: [EvaluationOption]
    let correctOptionID: String
    let explanation: String
    let studyRoute: String
    let visual: EvaluationVisual?

    var correctOption: EvaluationOption {
        options.first(where: { $0.id == correctOptionID })!
    }

    func option(withID optionID: String?) -> EvaluationOption? {
        guard let optionID else { return nil }
        return options.first(where: { $0.id == optionID })
    }

    func withShuffledOptions() -> EvaluationQuestion {
        EvaluationQuestion(
            id: id,
            moduleNumber: moduleNumber,
            moduleTitle: moduleTitle,
            prompt: prompt,
            options: options.shuffled(),
            correctOptionID: correctOptionID,
            explanation: explanation,
            studyRoute: studyRoute,
            visual: visual
        )
    }
}

enum EvaluationAttemptFactory {
    static let questionCount = 10

    static func makeAttempt(from bank: [EvaluationQuestion] = EvaluationQuestionBank.all) -> [EvaluationQuestion] {
        var selected: [EvaluationQuestion] = []

        for moduleNumber in 1...6 {
            let moduleQuestions = bank.filter { $0.moduleNumber == moduleNumber }
            if let question = moduleQuestions.randomElement() {
                selected.append(question)
            }
        }

        let selectedIDs = Set(selected.map(\.id))
        let remaining = bank.filter { !selectedIDs.contains($0.id) }.shuffled()
        selected.append(contentsOf: remaining.prefix(questionCount - selected.count))

        return selected
            .shuffled()
            .map { $0.withShuffledOptions() }
    }
}

