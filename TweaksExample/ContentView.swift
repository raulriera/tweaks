//
//  ContentView.swift
//  TweaksExample
//
//  Created by Raul Riera on 2026-01-14.
//

import SwiftUI
import Tweaks

struct ContentView: View {
    @Tweakable("appTitle") var title = "Hello, world!"
    @Tweakable("borderThickness") var borderThickness = 0.0
    @Tweakable("counter") var counter = 0
    @Tweakable("isDark") var isDarkMode: Bool = false
    @State var isTweaksPresented: Bool = false
    
    var body: some View {        
        VStack {
            Text(title)
            Text(counter, format: .number)
            Rectangle()
                .fill(.gray)
                .border(.black, width: borderThickness)
                .frame(width: 200, height: 200)
        }
        .sheet(isPresented: $isTweaksPresented) {
            TweaksEditor()
                .presentationDetents([.medium])
        }
        .toolbar {
            ToolbarItem {
                Button("Tweaks", systemImage: "rectangle.badge.sparkles") {
                    isTweaksPresented.toggle()
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
