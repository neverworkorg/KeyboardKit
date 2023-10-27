import SwiftUI

private struct KeyboardModifier<KeyboardView>: ViewModifier where KeyboardView: View {
    private let keyboardView: KeyboardView
    private let keyboardConfiguration: KeyboardConfiguration
    
    public func body(content: Content) -> some View {
        content
            .onReceive(
                NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)
            ) { notification in
                guard let textField = notification.object as? UITextField else {
                    return
                }
                
                guard
                    keyboardConfiguration.inputType == nil || keyboardConfiguration.inputType == textField.keyboardType
                else {
                    return
                }
                
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
    /// One of the keyboard types defined in the UIKeyboardType enumeration. If not provided, a custom keyboard will be used for all types.
    var inputType: UIKeyboardType?
    /// Constant that sets the appearance for an input view.
    var inputViewStyle: UIInputView.Style = .keyboard

    /// A Boolean value that indicates whether the input view is responsible for its own size. If false, the view size is equal to system-wide.
    var allowsSelfSizing: Bool = false
    
    public init(inputType: UIKeyboardType? = nil, inputViewStyle: UIInputView.Style = .keyboard, allowsSelfSizing: Bool = false) {
        self.inputType = inputType
        self.inputViewStyle = inputViewStyle
        self.allowsSelfSizing = allowsSelfSizing
    }
}

public extension View {
    /// Sets a view as a custom keyboard.
    /// - Parameters:
    ///   - type: One of the keyboard types defined in the UIKeyboardType enumeration. If not provided, a custom keyboard will be used for all types.
    ///   - allowsSelfSizing: A Boolean value that indicates whether the input view is responsible for its own size.
    ///   - content: A ViewBuilder that produces the view for the keyboard.
    func keyboard(_ type: UIKeyboardType? = nil, @ViewBuilder _ content: () -> some View) -> some View {
        modifier(KeyboardModifier(content(), configuration: KeyboardConfiguration(inputType: type)))
    }
    
    func keyboard(configuration: KeyboardConfiguration, @ViewBuilder _ content: () -> some View) -> some View {
        modifier(KeyboardModifier(content(), configuration: configuration))
    }
}
