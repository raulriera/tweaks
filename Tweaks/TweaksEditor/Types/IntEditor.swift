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
        
        let store = UserDefaults.standard
        var loadedValue = defaultValue
        
        if let data = store.data(forKey: Tweakable<Int>.storageKey),
           let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let storedValue = dict[key] as? Int {
            loadedValue = storedValue
        }
        
        _value = State(initialValue: loadedValue)
    }
    
    var body: some View {
        Stepper("Value: \(value)", value: $value)
            .onChange(of: value) {
                let store = UserDefaults.standard
                var dict: [String: Any] = [:]
                
                if let data = store.data(forKey: Tweakable<Int>.storageKey),
                   let existing = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    dict = existing
                }
                
                dict[key] = value
                
                if let data = try? JSONSerialization.data(withJSONObject: dict) {
                    store.set(data, forKey: Tweakable<Int>.storageKey)
                }
            }
    }
}
