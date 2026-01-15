//
//  TweakEditor.swift
//  Tweaks
//
//  Created by Raul Riera on 2026-01-14.
//

import SwiftUI

struct TweakEditor<Value: Equatable, Content: View>: View {
    let key: String
    let defaultValue: Value
    @State private var value: Value
    @ViewBuilder let content: (Binding<Value>) -> Content
    
    init(key: String,
         defaultValue: Value,
         @ViewBuilder content: @escaping (Binding<Value>) -> Content
    ) {
        self.key = key
        self.defaultValue = defaultValue
        self.content = content
        
        let initialValue = TweaksStore.shared.getValue(for: key, defaultValue: defaultValue)
        _value = State(initialValue: initialValue)
    }
    
    var body: some View {
        content($value)
            .onChange(of: value) {
                TweaksStore.shared.setValue(value, for: key)
            }
    }
}
