//
//  IntEditor.swift
//  Tweaks
//
//  Created by Raul Riera on 2026-01-14.
//

import SwiftUI

struct IntEditor: View {
    let key: String
    let defaultValue: Int
    
    @State private var value: Int
    
    init(key: String, defaultValue: Int) {
        self.key = key
        self.defaultValue = defaultValue
        let loadedValue = TweaksStore.shared.getValue(for: key, defaultValue: defaultValue)
        _value = State(initialValue: loadedValue)
    }
    
    var body: some View {
        Stepper("Value: \(value)", value: $value)
            .onChange(of: value) {
                TweaksStore.shared.setValue(value, for: key)
            }
    }
}
