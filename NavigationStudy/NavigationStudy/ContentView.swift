//
//  ContentView.swift
//  NavigationStudy
//
//  Created by 윤해수 on 11/1/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var stack: [String] = []
    
    var body: some View {
        TabView {
            NavigationDestinationView()
                .tabItem {
                    Text("First")
                }
            NavigationLinkView()
                .tabItem {
                    Text("Second")
                }
        }
    }
}

#Preview {
    ContentView()
}
