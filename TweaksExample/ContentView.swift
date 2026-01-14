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
    @State var isTweaksPresented: Bool = false
    
    var body: some View {        
        VStack {
            Text(title)
            Rectangle()
                .fill(.gray)
                .border(.black, width: borderThickness)
                .frame(width: 200, height: 200)
            Button("Show Tweaks") {
                isTweaksPresented.toggle()
            }
            .sheet(isPresented: $isTweaksPresented) {
                TweaksEditor()
                    .presentationDetents([.medium])
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
