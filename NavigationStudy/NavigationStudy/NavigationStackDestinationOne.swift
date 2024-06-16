//
//  NavigationStackDestinationOne.swift
//  NavigationStudy
//
//  Created by 윤해수 on 6/16/24.
//

import SwiftUI

struct NavigationStackDestinationOne: View {
    @Binding var stack: [String]
        
    var body: some View {
        VStack {
            Text("현재 스택은 \(stack).")
            
            NavigationLink("2 페이지로", value: "2")
            
            Button("stack 모두 없애기") {
                stack.removeAll()
            }
        }
    }
}

#Preview {
    NavigationStackDestinationOne(stack: .constant(["1"]))
}
