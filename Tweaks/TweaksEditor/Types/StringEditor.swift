//
//  StringEditor.swift
//  Tweaks
//
//  Created by Raul Riera on 2026-01-14.
//

import SwiftUI

struct StringEditor: View {
    let key: String
    let defaultValue: String
    
    @State private var value: String
    
    init(key: String, defaultValue: String) {
        self.key = key
        self.defaultValue = defaultValue
        
        let store = UserDefaults.standard
        var loadedValue = defaultValue
        
        if let data = store.data(forKey: Tweakable<String>.storageKey),
           let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let storedValue = dict[key] as? String {
            loadedValue = storedValue
        }
        
        _value = State(initialValue: loadedValue)
    }
    
    var body: some View {
        TextField("Enter value", text: $value)
            .textFieldStyle(.roundedBorder)
            .onChange(of: value) {
                let store = UserDefaults.standard
                var dict: [String: Any] = [:]
                
                if let data = store.data(forKey: Tweakable<String>.storageKey),
                   let existing = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    dict = existing
                }
                
                dict[key] = value
                
                if let data = try? JSONSerialization.data(withJSONObject: dict) {
                    store.set(data, forKey: Tweakable<String>.storageKey)
                }
            }
    }
}
