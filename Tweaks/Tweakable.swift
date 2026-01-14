//
//  Tweakable.swift
//  Tweaks
//
//  Created by Raul Riera on 2026-01-14.
//

import SwiftUI
import Combine

@propertyWrapper
public struct Tweakable<Value> {
    private let key: String
    private let defaultValue: Value
    
    public var wrappedValue: Value {
        get {
            TweaksStore.shared.getValue(for: key, defaultValue: defaultValue)
        }
        nonmutating set {
            TweaksStore.shared.setValue(newValue, for: key)
        }
    }
    
    public var projectedValue: Binding<Value> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    public init(wrappedValue: Value, _ key: String) {
        self.key = key
        self.defaultValue = wrappedValue
        
        if Value.self == String.self {
            TweaksRegistry.shared.register(key: key, type: .string, defaultValue: wrappedValue)
        } else if Value.self == Bool.self {
            TweaksRegistry.shared.register(key: key, type: .bool, defaultValue: wrappedValue)
        } else if Value.self == Int.self {
            TweaksRegistry.shared.register(key: key, type: .int, defaultValue: wrappedValue)
        } else if Value.self == Double.self {
            TweaksRegistry.shared.register(key: key, type: .double, defaultValue: wrappedValue)
        }
    }
}
