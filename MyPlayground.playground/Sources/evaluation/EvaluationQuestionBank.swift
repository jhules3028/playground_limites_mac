import Foundation

enum EvaluationQuestionBank {
    static let all: [EvaluationQuestion] = [
        question(
            id: "M1-P1", module: 1, title: "Intuitive Idea",
            prompt: "What does the expression lim x→a f(x) = L primarily describe?",
            choices: [
                ("A", "The value the function must take exactly at x = a.", "You confused the limit with f(a). A limit examines nearby points; the exact function value is a different question."),
                ("B", "The value that f(x) approaches as x approaches a.", nil),
                ("C", "The greatest value the function can reach.", "A limit does not represent a maximum. The function can approach L even if greater or smaller values occur elsewhere.")
            ], correct: "B",
            explanation: "A limit studies the trend of the function values around a. It does not require x to equal a or f(a) to exist.",
            route: "Introduction and approximation screens."
        ),
        question(
            id: "M1-P2", module: 1, title: "Intuitive Idea",
            prompt: "When we write x → 2, what should we understand?",
            choices: [
                ("A", "That we can use only x = 2.", "Substituting exactly x = 2 examines f(2), not necessarily the limit. An approximation uses neighboring values."),
                ("B", "That x must remain far from 2.", "The idea is to reduce the distance from 2, not keep it large."),
                ("C", "That we use values increasingly close to 2 without requiring them to equal 2 exactly.", nil)
            ], correct: "C",
            explanation: "The arrow represents a process of approximation. Values such as 1.9, 1.99, 2.01, or 2.001 let us study what happens around the target point.",
            route: "Slider playground."
        ),
        question(
            id: "M1-P3", module: 1, title: "Intuitive Idea",
            prompt: "As x approaches 5, the values of f(x) approach −2, but f(5) is not defined. Which conclusion is correct?",
            choices: [
                ("A", "The limit can be −2 even if f(5) does not exist.", nil),
                ("B", "The limit does not exist because f(5) is missing.", "You imposed a condition that a limit does not require. A hole can coexist with a perfectly well-defined limit."),
                ("C", "We can conclude that f(5) = −2.", "The approximation lets us determine the limit, but it does not allow us to invent a value for f(5).")
            ], correct: "A",
            explanation: "The existence of the limit depends on nearby behavior. The exact function value can be absent without destroying that trend.",
            route: "Summary about approaching without reaching."
        ),

        question(
            id: "M2-P1", module: 2, title: "Numerical Representation",
            prompt: "The table brings x toward 2 from both sides. What value does the function approach?",
            choices: [
                ("A", "2.", "2 is the value that x approaches, not the value that f(x) approaches."),
                ("B", "4.", nil),
                ("C", "0.", "The fact that the original expression produces 0/0 at x = 2 does not mean that the table values approach zero.")
            ], correct: "B",
            explanation: "Values from both sides approach 4: from below on the left and from above on the right.",
            route: "Table-reading screen.", visual: .numericalTable
        ),
        question(
            id: "M2-P2", module: 2, title: "Numerical Representation",
            prompt: "When x changes from 1.9 to 1.99, what happens to its distance from 2?",
            choices: [
                ("A", "It changes from 0.1 to 0.01; we are ten times closer.", nil),
                ("B", "The distance stays the same because both numbers begin with 1.", "Compare the difference from 2, not only the first written digits."),
                ("C", "We switch from approaching from the left to approaching from the right.", "Both 1.9 and 1.99 are less than 2, so both are on the left side.")
            ], correct: "A",
            explanation: "2 − 1.9 = 0.1 and 2 − 1.99 = 0.01. Adding precision reduces the distance by a factor of ten.",
            route: "Precision-selection screen."
        ),
        question(
            id: "M2-P3", module: 2, title: "Numerical Representation",
            prompt: "If a table of nearby values indicates that f(x) approaches 4 as x → 2, what can we conclude with certainty?",
            choices: [
                ("A", "Nearby behavior suggests a limit of 4, but the table alone does not determine f(2).", nil),
                ("B", "f(2) must equal 4.", "You extended a nearby trend to the exact value without enough information."),
                ("C", "The function is not defined at any point.", "The table shows many points where the function does have values; it does not support claiming that it is undefined everywhere.")
            ], correct: "A",
            explanation: "The table examines inputs near 2. If it does not include the exact definition of the function at 2, it cannot establish the value of f(2).",
            route: "Interpretation and conclusion screen."
        ),

        question(
            id: "M3-P1", module: 3, title: "Graphical Interpretation",
            prompt: "What information does the graph represent at x = 2?",
            choices: [
                ("A", "lim x→2 f(x) = 4 and f(2) does not exist.", nil),
                ("B", "The limit does not exist because there is a hole.", "You interpreted the hole as an absence of a trend. The hole affects f(2), but the curve from both sides still points to 4."),
                ("C", "f(2) = 4, even though there is no filled point.", "An open circle does not assign a value to the function. A filled point would be required to conclude that f(2) = 4.")
            ], correct: "A",
            explanation: "The curve approaches 4 from both sides, so the limit exists. The open circle indicates that the exact function value is missing.",
            route: "Graph-reading screen.", visual: .graphUndefined
        ),
        question(
            id: "M3-P2", module: 3, title: "Graphical Interpretation",
            prompt: "Observe the hole at (2, 4) and the filled point at (2, 6). Which interpretation is correct?",
            choices: [
                ("A", "The limit and f(2) both equal 6.", "You used the filled point to answer two different questions. That point determines f(2), but it does not change the nearby trend."),
                ("B", "lim x→2 f(x) = 4 and f(2) = 6.", nil),
                ("C", "The limit does not exist because there are two marks at x = 2.", "The two marks have different roles: one represents the trend, and the other represents the exact value. They do not create ambiguity in the limit.")
            ], correct: "B",
            explanation: "The nearby curve leads to the hole at 4; that is the limit. The filled point at 6 defines the exact value f(2).",
            route: "Screen comparing the three cases for f(a).", visual: .graphDifferent
        ),
        question(
            id: "M3-P3", module: 3, title: "Graphical Interpretation",
            prompt: "The curve passes through a filled point at (2, 4), with no holes or jumps. Which statement is correct?",
            choices: [
                ("A", "lim x→2 f(x) = 4 and f(2) = 4.", nil),
                ("B", "The limit equals 2 because that is the value of x.", "You confused the horizontal coordinate with the height of the function. x approaches 2, while f(x) approaches 4."),
                ("C", "f(2) exists, but the limit cannot be determined visually.", "The trend can be read from the nearby curve. Both sides lead to the same height.")
            ], correct: "A",
            explanation: "The curve approaches 4 from both sides, and the filled point confirms that the function also equals 4 at x = 2.",
            route: "Screen distinguishing the limit from the exact value.", visual: .graphContinuous
        ),

        question(
            id: "M4-P1", module: 4, title: "One-Sided Limits",
            prompt: "What does the minus sign in lim x→a⁻ f(x) indicate?",
            choices: [
                ("A", "That the result of the limit will be negative.", "You confused direction with numerical sign. A left-hand limit can produce a positive number, a negative number, or zero."),
                ("B", "That x approaches using values less than a.", nil),
                ("C", "That the function is always decreasing.", "Approaching from the left does not force the function to decrease; the curve could increase, decrease, or change in another way.")
            ], correct: "B",
            explanation: "The − sign indicates the side of approach. It does not describe the sign of the result or whether the function is increasing.",
            route: "Introduction and left-hand playground."
        ),
        question(
            id: "M4-P2", module: 4, title: "One-Sided Limits",
            prompt: "If lim x→2⁻ f(x) = 3 and lim x→2⁺ f(x) = 5, what happens to lim x→2 f(x)?",
            choices: [
                ("A", "It exists and equals 4 because that is the average.", "One-sided limits are not combined by averaging. Equality between them is a required condition."),
                ("B", "It exists and equals 5 because the right side is used.", "The right side does not take priority over the left. Both must lead to the same value."),
                ("C", "It does not exist because the one-sided limits are different.", nil)
            ], correct: "C",
            explanation: "A two-sided limit requires both one-sided limits to agree. They are not averaged, and neither one is chosen over the other.",
            route: "Condition-for-existence screen."
        ),
        question(
            id: "M4-P3", module: 4, title: "One-Sided Limits",
            prompt: "If lim x→a⁻ f(x) = −2 and lim x→a⁺ f(x) = −2, what can we conclude?",
            choices: [
                ("A", "The two-sided limit exists and equals −2.", nil),
                ("B", "It does not exist because the result is negative.", "A limit can be negative without any problem. What matters is that both sides agree."),
                ("C", "It equals 0 because the two sides cancel.", "The one-sided limits are not added or canceled; they are compared to verify that they are equal.")
            ], correct: "A",
            explanation: "The one-sided limits exist and agree at −2; therefore, the two-sided limit exists and has that same value.",
            route: "Comparison of matching and differing one-sided limits."
        ),

        question(
            id: "M5-P1", module: 5, title: "Algebraic Techniques",
            prompt: "Calculate lim x→2 (3x + 1).",
            choices: [
                ("A", "6", "You calculated 3 × 2 but forgot to add the +1 term."),
                ("B", "7", nil),
                ("C", "8", "Check the multiplication and addition: 3(2) is 6, not 7; then add 1.")
            ], correct: "B",
            explanation: "The linear function is defined at x = 2. Substituting directly: 3(2) + 1 = 6 + 1 = 7.",
            route: "Direct-substitution screen."
        ),
        question(
            id: "M5-P2", module: 5, title: "Algebraic Techniques",
            prompt: "Substituting the target point into a quotient produces 0/0. What does this mean?",
            choices: [
                ("A", "That the limit always equals 0.", "Zero divided by zero is not evaluated as zero. Different expressions with the form 0/0 can have different limits."),
                ("B", "That the limit automatically does not exist.", "The indeterminate form does not prove nonexistence. In many examples, the limit emerges after simplification."),
                ("C", "That direct substitution is not enough and we must transform the expression.", nil)
            ], correct: "C",
            explanation: "0/0 is an indeterminate form. It can hide different limits, so we must factor, rationalize, or obtain another equivalent expression.",
            route: "Screen about the indeterminate form 0/0."
        ),
        question(
            id: "M5-P3", module: 5, title: "Algebraic Techniques",
            prompt: "Calculate lim x→2 (x² − 4)/(x − 2).",
            choices: [
                ("A", "0", "You interpreted 0/0 as zero. You must factor before deciding the value of the limit."),
                ("B", "2", "You probably kept only the target point. After simplifying, x + 2 remains, so you must calculate 2 + 2."),
                ("C", "4", nil)
            ], correct: "C",
            explanation: "x² − 4 = (x − 2)(x + 2). For x ≠ 2, the factor x − 2 cancels, leaving x + 2; substitution then gives 4.",
            route: "Factoring screen."
        ),

        question(
            id: "M6-P1", module: 6, title: "Continuity",
            prompt: "Which set of conditions guarantees that f is continuous at x = a?",
            choices: [
                ("A", "Only that f(a) exists.", "A filled point can exist even when the curve has a jump and the two-sided limit does not exist."),
                ("B", "That f(a) exists, lim x→a f(x) exists, and both values are equal.", nil),
                ("C", "Only that the one-sided limits are positive numbers.", "Limits can be negative or zero. The relevant condition is that the one-sided limits agree and that the result equals f(a).")
            ], correct: "B",
            explanation: "Continuity simultaneously requires an exact value, a two-sided limit, and equality between them.",
            route: "Three-conditions screen."
        ),
        question(
            id: "M6-P2", module: 6, title: "Continuity",
            prompt: "At x = 2, the limit exists and equals 4, but f(2) is not defined. Which behavior occurs?",
            choices: [
                ("A", "The function is continuous at x = 2.", "The first condition fails because f(2) does not exist, and equality with the limit also fails."),
                ("B", "A removable discontinuity.", nil),
                ("C", "A jump discontinuity.", "At a jump, the one-sided limits are different. Here both sides approach 4.")
            ], correct: "B",
            explanation: "There is a hole that can be repaired by defining f(2) = 4. The limit already exists; the exact value must be made to match it.",
            route: "Removable-discontinuity case."
        ),
        question(
            id: "M6-P3", module: 6, title: "Continuity",
            prompt: "Suppose f(2) = 5, lim x→2⁻ f(x) = 3, and lim x→2⁺ f(x) = 5. Why is the function not continuous?",
            choices: [
                ("A", "Because f(2) does not exist.", "The prompt explicitly gives f(2) = 5, so the first condition is satisfied."),
                ("B", "Because the two-sided limit does not exist: the one-sided limits are different.", nil),
                ("C", "Because a continuous function must equal zero at the point.", "Continuity does not require the value to be zero. It requires the limit to exist and equal f(2).")
            ], correct: "B",
            explanation: "Although f(2) is defined, the one-sided limits 3 and 5 do not agree. The two-sided limit does not exist, so continuity fails.",
            route: "Jump-discontinuity case."
        )
    ]

    private typealias Choice = (id: String, text: String, feedback: String?)

    private static func question(
        id: String,
        module: Int,
        title: String,
        prompt: String,
        choices: [Choice],
        correct: String,
        explanation: String,
        route: String,
        visual: EvaluationVisual? = nil
    ) -> EvaluationQuestion {
        EvaluationQuestion(
            id: id,
            moduleNumber: module,
            moduleTitle: title,
            prompt: prompt,
            options: choices.map {
                EvaluationOption(id: $0.id, text: $0.text, incorrectFeedback: $0.feedback)
            },
            correctOptionID: correct,
            explanation: explanation,
            studyRoute: route,
            visual: visual
        )
    }
}
