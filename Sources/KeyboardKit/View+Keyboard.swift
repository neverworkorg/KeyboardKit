import SwiftUI

private struct KeyboardModifier<KeyboardView>: ViewModifier where KeyboardView: View {
    private let keyboardView: KeyboardView
    private let keyboardType: UIKeyboardType?
    
    public func body(content: Content) -> some View {
        content
            .onReceive(
                NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)
            ) { notification in
                guard let textField = notification.object as? UITextField else {
                    return
                }
                
                guard keyboardType == nil || textField.keyboardType == keyboardType else {
                    return
                }
                
                textField.inputView = InputView(rootView: keyboardView, inputViewStyle: .keyboard)
            }
    }
    
    public init(_ keyboardView: KeyboardView, for keyboardType: UIKeyboardType? = nil) {
        self.keyboardView = keyboardView
        self.keyboardType = keyboardType
    }
}

public extension View {
    /// Sets a view as a custom keyboard.
    /// - Parameters:
    ///   - type: One of the keyboard types defined in the UIKeyboardType enumeration. If not provided, a custom keyboard will be used for all types.
    ///   - allowsSelfSizing: A Boolean value that indicates whether the input view is responsible for its own size. If false, the view size is equal to system-wide.
    ///   - content: A ViewBuilder that produces the view for the keyboard.
    func keyboard(_ type: UIKeyboardType? = nil, allowsSelfSizing: Bool = false, @ViewBuilder _ content: () -> some View) -> some View {
        modifier(KeyboardModifier(content(), for: type))
    }
}
