//
//  TweaksEditor.swift
//  Tweaks
//
//  Created by Raul Riera on 2026-01-14.
//

import SwiftUI

public struct TweaksEditor: View {
    private let registry = TweaksRegistry.shared
    
    public init() {}
    
    public var body: some View {
        Form {
            ForEach(registry.entries) { entry in
                VStack(alignment: .leading, spacing: 8) {                    
                    switch entry.type {
                    case .string:
                        TweakEditor(key: entry.key, defaultValue: entry.defaultValue as? String ?? "") { $value in
                            Section(header: Text(entry.key)) {
                                TextField("Enter value", text: $value)
                                    .textFieldStyle(.roundedBorder)
                            }
                        }
                        
                    case .bool:
                        TweakEditor(key: entry.key, defaultValue: entry.defaultValue as? Bool ?? false) { $value in
                            Toggle(entry.key, isOn: $value)
                        }
                        
                    case .int:
                        TweakEditor(key: entry.key, defaultValue: entry.defaultValue as? Int ?? 0) { $value in
                            Stepper("\(value)", value: $value)
                        }
                        
                    case .double:
                        TweakEditor(key: entry.key, defaultValue: entry.defaultValue as? Double ?? 0.0) { $value in
                            Section(header: Text(entry.key)) {
                                TextField("0.0", value: $value, format: .number)
                                    .textFieldStyle(.roundedBorder)
                                #if os(iOS)
                                    .keyboardType(.decimalPad)
                                #endif
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Tweaks Editor")
    }
}
