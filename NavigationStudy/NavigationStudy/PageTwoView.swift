//
//  PageTwoView.swift
//  NavigationStudy
//
//  Created by 윤해수 on 11/1/23.
//

import SwiftUI

struct PageTwoView: View {
    
    @Binding var stack: [String]
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            
            Button("이전으로") {
                print(stack)
                stack.removeLast()
                print(stack)
            }
            
            Button("처음으로") {
                print(stack)
                stack.removeAll()
                print(stack)
            }
        }
        .navigationDestination(for: String.self) { stack in
            if stack == "" {
                ContentView()
            } else if stack == "1" {
                PageOneView(stack: $stack)
            }
        }
    }
}

//#Preview {
//    PageTwoView(stack: $stack)
//}
