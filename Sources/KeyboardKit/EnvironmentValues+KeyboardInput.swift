import SwiftUI

struct KeyboardInputKey: EnvironmentKey {
    static let defaultValue = KeyboardInput(.shared, enableInputClicks: true)
}

public extension EnvironmentValues {
    /// Keyboard input provides insert, delete and dismiss methods to implement simple text entry. It also lets you find out if the text object is empty.
    var keyboardInput: KeyboardInput {
        get { self[KeyboardInputKey.self] }
        set { self[KeyboardInputKey.self] = newValue }
    }
}
