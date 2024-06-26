//
//  PageOneView.swift
//  NavigationStudy
//
//  Created by 윤해수 on 11/1/23.
//

import SwiftUI

struct NavigationDestinationViewOne: View {
    @Binding var stack: [String]
        
    var body: some View {
        VStack {
            Text("현재 스택은 \(stack).")
            
            NavigationLink("2 페이지로", value: "2")
            
            Button("이전으로") {
                print(stack)
                stack.removeLast()
                print(stack)
            }
            
            Button("stack 모두 없애기") {
                stack.removeAll()
            }
        }
    }
}

#Preview {
    NavigationDestinationViewOne(stack: .constant(["1"]))
}
