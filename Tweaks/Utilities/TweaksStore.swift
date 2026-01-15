//
//  TweaksStore.swift
//  Tweaks
//
//  Created by Raul Riera on 2026-01-14.
//

import SwiftUI
import Combine

@Observable
class TweaksStore {
    static let shared = TweaksStore()
    
    private let storageKey = "__tweaks_storage__"
    private let store = UserDefaults.standard
    private var cancellable: AnyCancellable?
    private var _internalCounter = 0
    
    private init() {
        cancellable = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?._internalCounter += 1
            }
    }
    
    func getValue<T>(for key: String, defaultValue: T) -> T {
        _ = _internalCounter
        
        guard let data = store.data(forKey: storageKey),
              let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let value = dict[key] as? T else {
            return defaultValue
        }
        return value
    }
    
    func setValue<T>(_ value: T, for key: String) {
        var dict: [String: Any] = [:]
        
        if let data = store.data(forKey: storageKey),
           let existing = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            dict = existing
        }
        
        dict[key] = value
        
        if let data = try? JSONSerialization.data(withJSONObject: dict) {
            store.set(data, forKey: storageKey)
        }
    }
}
