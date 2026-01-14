//
//  DoubleEditor.swift
//  Tweaks
//
//  Created by Raul Riera on 2026-01-14.
//

import SwiftUI

struct DoubleEditor: View {
    let key: String
    let defaultValue: Double
    
    @State private var value: Double
    
    init(key: String, defaultValue: Double) {
        self.key = key
        self.defaultValue = defaultValue
        let loadedValue = TweaksStore.shared.getValue(for: key, defaultValue: defaultValue)
        _value = State(initialValue: loadedValue)
    }
    
    var body: some View {
        Section(header: Text(key)) {
            TextField("0.0", value: $value, format: .number)
                .textFieldStyle(.roundedBorder)
            #if iOS
                .keyboardType(.decimalPad)
            #endif
        }
        .onChange(of: value) {
            TweaksStore.shared.setValue(value, for: key)
        }
    }
}
