import UIKit

public struct KeyboardInput {
    /// Primary view controller for a custom keyboard.
    private let inputViewController: UIInputViewController
    /// A proxy to the text input object that the custom keyboard is interacting with.
    private var inputProxy: UITextDocumentProxy { inputViewController.textDocumentProxy }
    /// Triggers input click for a custom keyboard. A click plays only if the user has enabled keyboard clicks in Settings > Sounds.
    private let inputClick: () -> Void
    
    /// Inserts a text into the displayed text.
    public func callAsFunction(_ text: String) {
        inputProxy.insertText(text); inputClick()
    }
    
    /// Deletes a character from the displayed text.
    /// - Discussion: Remove the character just before the cursor from your class’s backing store and redisplay the text.
    public func delete() {
        inputProxy.deleteBackward(); inputClick()
    }
    
    /// A Boolean value that indicates whether the text-entry object has any text.
    public var isEmpty: Bool {
        inputProxy.hasText == false
    }
    
    public init(_ inputViewController: UIInputViewController, enableInputClicks: Bool) {
        self.inputViewController = inputViewController
        self.inputClick = enableInputClicks ? UIDevice.current.playInputClick : { }
    }
}

extension KeyboardInput {
    /// Dismisses the keyboard from the screen.
    public func dismiss() {
        /// The right way of dismissal is call of `UIInputViewController.dismissKeyboard()`, but that will require to have retained verios of it.
        inputViewController.dismissKeyboard()
    }
}

extension KeyboardInput {
    /// An object that provides textual context to a keyboard.
    public var context: UITextDocumentProxy {
        inputProxy
    }
}

public extension UIInputViewController {
    /// - Note: Any instance of `UIInputViewController` could be used for text entry. It's not tied to `inputView`.
    static let shared = UIInputViewController()
}
