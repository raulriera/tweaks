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
        
        let store = UserDefaults.standard
        var loadedValue = defaultValue
        
        if let data = store.data(forKey: Tweakable<Double>.storageKey),
           let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let storedValue = dict[key] as? Double {
            loadedValue = storedValue
        }
        
        _value = State(initialValue: loadedValue)
    }
    
    var body: some View {
        HStack {
            Text("Value:")
            TextField("0.0", value: $value, format: .number)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
        }
        .onChange(of: value) {
            let store = UserDefaults.standard
            var dict: [String: Any] = [:]
            
            if let data = store.data(forKey: Tweakable<Double>.storageKey),
               let existing = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                dict = existing
            }
            
            dict[key] = value
            
            if let data = try? JSONSerialization.data(withJSONObject: dict) {
                store.set(data, forKey: Tweakable<Double>.storageKey)
            }
        }
    }
}
