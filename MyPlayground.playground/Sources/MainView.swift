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

            case .algebraicLimit:
                ModuleFiveView(
                    onExit: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.goToCover()
                        }
                    },
                    onPreviousModule: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.go(to: .oneSidedLimits)
                        }
                    },
                    onComplete: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.completeModuleFive()
                        }
                    }
                )
                .transition(.opacity.combined(with: .move(edge: .trailing)))

            case .continuity:
                ModuleSixView(
                    onExit: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.goToCover()
                        }
                    },
                    onPreviousModule: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.go(to: .algebraicLimit)
                        }
                    },
                    onComplete: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.completeModuleSix()
                        }
                    }
                )
                .transition(.opacity.combined(with: .move(edge: .trailing)))

            case .assessment:
                EvaluationView(
                    onExit: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.goToCover()
                        }
                    },
                    onPreviousModule: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.go(to: .continuity)
                        }
                    },
                    onStudyModule: { moduleNumber in
                        withAnimation(.easeInOut(duration: 0.35)) {
                            appState.goToModule(moduleNumber)
                        }
                    },
                    onSubmit: {
                        appState.completeAssessment()
                    }
                )
                .transition(.opacity.combined(with: .move(edge: .trailing)))

            }
        }
        .frame(minWidth: 760, minHeight: 600)
        .preferredColorScheme(.dark)
    }
}
