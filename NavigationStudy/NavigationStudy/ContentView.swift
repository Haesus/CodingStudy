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
            NavigationViewOne()
                .tabItem {
                    Text("iOS 16 이전")
                }
            NormallyNavigationLinkOne()
                .tabItem {
                    Text("일반적인 네이게이션 사용")
                }
            NavigationDestinationOne()
                .tabItem {
                    Text("Value 네비게이션")
                }
            NavigationStackDestination()
                .tabItem {
                    Text("path 네비게이션")
                }
            NavigationDestinationView()
                .tabItem {
                    Text("path button 네비게이션")
                }
        }
    }
}

#Preview {
    ContentView()
}
