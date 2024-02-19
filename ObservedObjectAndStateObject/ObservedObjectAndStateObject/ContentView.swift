//
//  ContentView.swift
//  ObservedObjectAndStateObject
//
//  Created by 윤해수 on 12/6/23.
//

import SwiftUI

struct ContentView: View {
    @State var randomNumber = (0..<1000).randomElement()!
    
    var body: some View {
        VStack {
            Spacer()
            Text("랜덤 숫자 : \(randomNumber)")
            Button("Randomize number") {
                randomNumber = (0..<1000).randomElement()!
            }
        }
        TabView {
            ObservedObjectView()
                .tabItem {
                    Text("ObservedObject View")
                }
            StateObjectView()
                .tabItem {
                    Text("StateObject View")
                }
        }
    }
}

#Preview {
    ContentView()
}
