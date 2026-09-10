import AppKit
import SwiftUI

@MainActor
func makePlaygroundView() -> NSView {
    let appState = AppState()
    let rootView = MainView(appState: appState)
    let hostingView = NSHostingView(rootView: rootView)

    hostingView.frame = NSRect(x: 0, y: 0, width: 1_100, height: 720)
    return hostingView
}
