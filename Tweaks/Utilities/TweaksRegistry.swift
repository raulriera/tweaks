//
//  TweaksRegistry.swift
//  Tweaks
//
//  Created by Raul Riera on 2026-01-14.
//

import SwiftUI

@Observable
class TweaksRegistry {
    static let shared = TweaksRegistry()
    
    var entries: [StorageEntry] = []
    
    struct StorageEntry: Identifiable {
        let id = UUID()
        let key: String
        let type: StorageType
        let defaultValue: Any
        
        enum StorageType {
            case string
            case bool
            case int
            case double
        }
    }
    
    func register(key: String, type: StorageEntry.StorageType, defaultValue: Any) {
        if !entries.contains(where: { $0.key == key }) {
            entries.append(StorageEntry(key: key, type: type, defaultValue: defaultValue))
        }
    }
}
