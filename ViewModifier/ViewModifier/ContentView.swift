//
//  ContentView.swift
//  ViewModifier
//
//  Created by 윤해수 on 6/24/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CommonView()
                .tabItem {
                    Text("CommonView")
                }
            
            CommonModifierView()
                .tabItem {
                    Text("CommonModifierView")
                }
            
            CustomAlertResultView(title: "", firstaction: "")
                .tabItem {
                    Text("CustomAlertView")
                }
            
            GenericModifierView()
                .tabItem {
                    Text("GenericModifierView")
                }
        }
    }
}

#Preview {
    ContentView()
}
