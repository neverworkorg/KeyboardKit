# KeyboardKit

## Quick Start

```swift
struct MainView: View {
    var body: some View {
        ContentView()
            .keyboard(.decimalPad) {
                NumericKeyboardView() // Any custom view as keyboard view.
            }
    }
}
```

```swift
struct NumericKeyboardView: View {
    @Environment(\.keyboardInput) var keyboardInput // Environment value could be accessed from any place for native and custom keyboard.
    
    var body: some View {
        VStack {
            Button("1") { keyboardInput("1") }
            Button("A") { keyboardInput("A") }
            Button("Confirm", action: keyboardInput.return)
            Button("Delete", action: keyboardInput.delete)
            
            Button("Dismiss Keyboard") {
                keyboardInput.dismiss()
            }
        }
    }
}
```