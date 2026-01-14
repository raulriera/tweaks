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
        
        let store = UserDefaults.standard
        var loadedValue = defaultValue
        
        if let data = store.data(forKey: Tweakable<Bool>.storageKey),
           let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let storedValue = dict[key] as? Bool {
            loadedValue = storedValue
        }
        
        _value = State(initialValue: loadedValue)
    }
    
    var body: some View {
        Toggle("Enabled", isOn: $value)
            .onChange(of: value) {
                let store = UserDefaults.standard
                var dict: [String: Any] = [:]
                
                if let data = store.data(forKey: Tweakable<Bool>.storageKey),
                   let existing = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    dict = existing
                }
                
                dict[key] = value
                
                if let data = try? JSONSerialization.data(withJSONObject: dict) {
                    store.set(data, forKey: Tweakable<Bool>.storageKey)
                }
            }
    }
}
