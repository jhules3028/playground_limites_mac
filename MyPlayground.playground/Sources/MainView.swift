import SwiftUI

struct MainView: View {
    @StateObject private var appState: AppState

    init(appState: AppState) {
        _appState = StateObject(wrappedValue: appState)
    }

    var body: some View {
        ZStack {
            AppTheme.background
                .ignoresSafeArea()

            switch appState.currentSection {
            case .cover:
                CoverView {
                    withAnimation(.easeInOut(duration: 0.45)) {
                        appState.startLearning()
                    }
                }
                .transition(.opacity.combined(with: .scale(scale: 0.985)))

            case .intuitiveLimit:
                ModuleOneView(
                    onExit: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.goToCover()
                        }
                    },
                    onComplete: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.completeModuleOne()
                        }
                    }
                )
                .transition(.opacity.combined(with: .move(edge: .trailing)))

            case .numericalLimit:
                ModuleTwoView(
                    onExit: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.goToCover()
                        }
                    },
                    onPreviousModule: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.go(to: .intuitiveLimit)
                        }
                    },
                    onComplete: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.completeModuleTwo()
                        }
                    }
                )
                .transition(.opacity.combined(with: .move(edge: .trailing)))

            case .graphicalLimit:
                ModuleThreeView(
                    onExit: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.goToCover()
                        }
                    },
                    onPreviousModule: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.go(to: .numericalLimit)
                        }
                    },
                    onComplete: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.completeModuleThree()
                        }
                    }
                )
                .transition(.opacity.combined(with: .move(edge: .trailing)))

            case .oneSidedLimits:
                ModuleFourView(
                    onExit: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.goToCover()
                        }
                    },
                    onPreviousModule: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.go(to: .graphicalLimit)
                        }
                    },
                    onComplete: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.completeModuleFour()
                        }
                    }
                )
                .transition(.opacity.combined(with: .move(edge: .trailing)))

            default:
                ModulePlaceholderView(
                    section: appState.currentSection,
                    onBack: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.goToCover()
                        }
                    }
                )
                .transition(.opacity.combined(with: .move(edge: .trailing)))
            }
        }
        .frame(minWidth: 760, minHeight: 600)
        .preferredColorScheme(.dark)
    }
}

private struct ModulePlaceholderView: View {
    let section: AppSection
    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            ZStack {
                Circle()
                    .fill(AppTheme.gold.opacity(0.12))
                    .frame(width: 132, height: 132)

                Circle()
                    .stroke(AppTheme.gold, lineWidth: 2)
                    .frame(width: 108, height: 108)

                Text("lim")
                    .font(.system(size: 40, weight: .bold, design: .serif))
                    .foregroundStyle(AppTheme.warmWhite)
            }

            VStack(spacing: 10) {
                if let number = section.moduleNumber {
                    Text("MÓDULO \(number)")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .tracking(2.2)
                        .foregroundStyle(AppTheme.softGold)
                }

                Text(section.title)
                    .font(.system(size: 38, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.warmWhite)

                Text("La portada ya está conectada. Desarrollaremos el contenido de este módulo en la siguiente etapa.")
                    .font(.system(size: 16))
                    .foregroundStyle(AppTheme.mutedText)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 520)
            }

            Button(action: onBack) {
                Label("Volver a la portada", systemImage: "arrow.left")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppTheme.deepNavy)
                    .padding(.horizontal, 22)
                    .padding(.vertical, 12)
                    .background(AppTheme.gold)
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)

            Spacer()
        }
        .padding(48)
    }
}
