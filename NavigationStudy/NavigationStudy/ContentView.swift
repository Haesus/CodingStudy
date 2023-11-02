//
//  ContentView.swift
//  NavigationStudy
//
//  Created by 윤해수 on 11/1/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationDestinationView()
                .tabItem {
                    Text("첫번째 네비게이션")
                }
            NavigationLinkView()
                .tabItem {
                    Text("두번째 네비게이션")
                }
        }
    }
}

#Preview {
    ContentView()
}
