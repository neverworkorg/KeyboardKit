import SwiftUI
import SwiftUIIntrospect

private struct KeyboardModifier<KeyboardView>: ViewModifier where KeyboardView: View {
    private let keyboardView: KeyboardView
    private let keyboardConfiguration: KeyboardConfiguration
    
    public func body(content: Content) -> some View {
        content
            .keyboardType(keyboardConfiguration.inputType)
            .introspect(.textField, on: .iOS(.v13, .v14, .v15, .v16, .v17)) { textField in
                let inputView = InputView(rootView: keyboardView, inputViewStyle: keyboardConfiguration.inputViewStyle)
                inputView.allowsSelfSizing = keyboardConfiguration.allowsSelfSizing
                textField.inputView = inputView
            }
    }
    
    public init(_ view: KeyboardView, configuration: KeyboardConfiguration) {
        self.keyboardView = view
        self.keyboardConfiguration = configuration
    }
}

public struct KeyboardConfiguration {
    /// One of the keyboard types defined in the UIKeyboardType enumeration.
    var inputType: UIKeyboardType = .default
    /// Constant that sets the appearance for an input view.
    var inputViewStyle: UIInputView.Style = .keyboard

    /// A Boolean value that indicates whether the input view is responsible for its own size. If false, the view size is equal to system-wide.
    var allowsSelfSizing: Bool = false
    
    public init(inputType: UIKeyboardType = .default, inputViewStyle: UIInputView.Style = .keyboard, allowsSelfSizing: Bool = false) {
        self.inputType = inputType
        self.inputViewStyle = inputViewStyle
        self.allowsSelfSizing = allowsSelfSizing
    }
}

public extension View {
    /// Sets a view as a custom keyboard.
    /// - Parameters:
    ///   - inputType: One of the keyboard types defined in the UIKeyboardType enumeration.
    ///   - content: A ViewBuilder that produces the view for the keyboard.
    func keyboard(_ inputType: UIKeyboardType = .default, @ViewBuilder _ content: () -> some View) -> some View {
        modifier(KeyboardModifier(content(), configuration: KeyboardConfiguration(inputType: inputType)))
    }
    
    func keyboard(configuration: KeyboardConfiguration, @ViewBuilder _ content: () -> some View) -> some View {
        modifier(KeyboardModifier(content(), configuration: configuration))
    }
}
