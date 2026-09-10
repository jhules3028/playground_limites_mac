import PlaygroundSupport

/// Starts the complete learning experience from the Playground entry point.
public func launchPlayground() {
    PlaygroundPage.current.needsIndefiniteExecution = true

    Task { @MainActor in
        PlaygroundPage.current.liveView = makePlaygroundView()
    }
}
