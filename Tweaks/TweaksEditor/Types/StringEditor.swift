import SwiftUI

struct StringEditor: View {
    let key: String
    let defaultValue: String
    
    @State private var value: String
    
    init(key: String, defaultValue: String) {
        self.key = key
        self.defaultValue = defaultValue
        let loadedValue = TweaksStore.shared.getValue(for: key, defaultValue: defaultValue)
        _value = State(initialValue: loadedValue)
    }
    
    var body: some View {
        Section(header: Text(key)) {
            TextField("Enter value", text: $value)
                .textFieldStyle(.roundedBorder)
                .onChange(of: value) {
                    TweaksStore.shared.setValue(value, for: key)
                }
        }
    }
}
