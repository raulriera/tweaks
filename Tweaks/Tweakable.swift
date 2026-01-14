//
//  Tweakable.swift
//  Tweaks
//
//  Created by Raul Riera on 2026-01-14.
//

import SwiftUI
import Combine

@propertyWrapper
public struct Tweakable<Value>: DynamicProperty {
    static var storageKey: String { "__tweaks_storage__" }
    
    @State private var storageObserver: StorageObserver
    private let key: String
    private let defaultValue: Value
    private let store: UserDefaults
    
    public var wrappedValue: Value {
        get {
            _ = storageObserver.updateTrigger
            
            guard let data = store.data(forKey: Self.storageKey),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let value = dict[key] as? Value else {
                return defaultValue
            }
            return value
        }
        nonmutating set {
            var dict: [String: Any] = [:]
            
            if let data = store.data(forKey: Self.storageKey),
               let existing = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                dict = existing
            }
            
            dict[key] = newValue
            
            if let data = try? JSONSerialization.data(withJSONObject: dict) {
                store.set(data, forKey: Self.storageKey)
            }
            
            storageObserver.updateTrigger += 1
        }
    }
    
    public var projectedValue: Binding<Value> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    public init(wrappedValue: Value, _ key: String, store: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = wrappedValue
        self.store = store
        self.storageObserver = StorageObserver(key: key, store: store)
        
        // Register with the registry based on type
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
