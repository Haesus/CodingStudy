//
//  NavigationStackDestinationOne.swift
//  NavigationStudy
//
//  Created by 윤해수 on 6/16/24.
//

import SwiftUI

struct NavigationStackDestination: View {
    @State private var stack: [String] = []
    
    var body: some View {
        NavigationStack(path: $stack) {
            VStack {
                NavigationLink("1스택 쌓기", value: "1")
                NavigationLink("2스택 쌓기", value: "2")
            }
            
            .navigationDestination(for: String.self) { stack in
                NavigationStackDestinationOne(stack: $stack)
            }
        }
    }
}

#Preview {
    NavigationStackDestination()
}
