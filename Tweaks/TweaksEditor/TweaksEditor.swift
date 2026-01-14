//
//  TweaksEditor.swift
//  Tweaks
//
//  Created by Raul Riera on 2026-01-14.
//

import SwiftUI

public struct TweaksEditor: View {
    @State private var registry = TweaksRegistry.shared
    
    public init() {}
    
    public var body: some View {
        List {
            ForEach(registry.entries) { entry in
                VStack(alignment: .leading, spacing: 8) {
                    Text(entry.key)
                        .font(.headline)
                    
                    switch entry.type {
                    case .string:
                        StringEditor(
                            key: entry.key,
                            defaultValue: entry.defaultValue as? String ?? ""
                        )
                        
                    case .bool:
                        BoolEditor(
                            key: entry.key,
                            defaultValue: entry.defaultValue as? Bool ?? false
                        )
                        
                    case .int:
                        IntEditor(
                            key: entry.key,
                            defaultValue: entry.defaultValue as? Int ?? 0
                        )
                        
                    case .double:
                        DoubleEditor(
                            key: entry.key,
                            defaultValue: entry.defaultValue as? Double ?? 0.0
                        )
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Tweaks Editor")
    }
}
