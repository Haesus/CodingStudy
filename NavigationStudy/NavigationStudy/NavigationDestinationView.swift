//
//  NavigationDestinationView.swift
//  NavigationStudy
//
//  Created by 윤해수 on 11/2/23.
//

import SwiftUI

struct NavigationDestinationView: View {
    
    @State private var stack: [String] = []
    
    var body: some View {
        NavigationStack(path: $stack) {
            Button(action: {
                stack.append("1")
                print(stack)
            }, label: {
                Text("페이지 1로")
            })
            .navigationDestination(for: String.self) { value in
                if value == "1" {
                    PageOneView(stack: $stack)
                } else if value == "2" {
                    PageTwoView(stack: $stack)
                }
            }
        }

    }
}

#Preview {
    NavigationDestinationView()
}
