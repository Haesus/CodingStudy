//
//  ContentView.swift
//  SwiftUIAnimationTest
//
//  Created by 한수빈 on 6/19/24.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 1
    var body: some View {
        TabView(selection: $selection) {
            AnimalScrollView()
                .tabItem { Text("Animal") }.tag(1)
            GradientScrollView()
                .tabItem { Text("gradient") }.tag(2)
            TwirlView()
                .tabItem { Text("TwirlView") }.tag(3)
            
//            MeshGradientView()
//                .tabItem { Text("MeshGradient") }.tag(4)
//            RippleEffectView()
//                .tabItem { Text("RippleEffetView") }.tag(5)

        }
    }
}

#Preview {
    ContentView()
}
