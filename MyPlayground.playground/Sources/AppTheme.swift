import SwiftUI

enum AppTheme {
    static let navy = Color(red: 0.025, green: 0.16, blue: 0.27)
    static let deepNavy = Color(red: 0.012, green: 0.075, blue: 0.14)
    static let blue = Color(red: 0.035, green: 0.28, blue: 0.45)
    static let lightBlue = Color(red: 0.23, green: 0.68, blue: 0.86)
    static let gold = Color(red: 0.82, green: 0.65, blue: 0.08)
    static let softGold = Color(red: 0.96, green: 0.82, blue: 0.28)
    static let warmWhite = Color(red: 0.97, green: 0.97, blue: 0.94)
    static let mutedText = Color.white.opacity(0.68)

    static let background = LinearGradient(
        colors: [deepNavy, navy, Color(red: 0.025, green: 0.21, blue: 0.33)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let cardBackground = LinearGradient(
        colors: [Color.white.opacity(0.105), Color.white.opacity(0.045)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
