//
//  BoolEditor.swift
//  Tweaks
//
//  Created by Raul Riera on 2026-01-14.
//

import SwiftUI

struct BoolEditor: View {
    let key: String
    let defaultValue: Bool
    
    @State private var value: Bool
    
    init(key: String, defaultValue: Bool) {
        self.key = key
        self.defaultValue = defaultValue
        let loadedValue = TweaksStore.shared.getValue(for: key, defaultValue: defaultValue)
        _value = State(initialValue: loadedValue)
    }
    
    var body: some View {
        Toggle("Enabled", isOn: $value)
            .onChange(of: value) {
                TweaksStore.shared.setValue(value, for: key)
            }
    }
}
