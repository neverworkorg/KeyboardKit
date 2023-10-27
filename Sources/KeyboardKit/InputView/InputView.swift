import UIKit
import SwiftUI

class InputView<Content>: UIInputView, UIInputViewAudioFeedback where Content: View {
    /// Input clicks will be produced only if the user has also enabled keyboard clicks in Settings > Sounds.
    var enableInputClicksWhenVisible: Bool { true }
    
    init(rootView: Content, inputViewStyle: UIInputView.Style) {
        super.init(frame: .zero, inputViewStyle: inputViewStyle)
        translatesAutoresizingMaskIntoConstraints = false
        
        let hostingView = _UIHostingView<Content>(rootView: rootView)
        addSubview(hostingView)
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingView.topAnchor.constraint(equalTo: topAnchor),
            hostingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            hostingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
