//
//  PageOneView.swift
//  NavigationStudy
//
//  Created by 윤해수 on 11/1/23.
//

import SwiftUI

struct PageOneView: View {
    
    @Binding var stack: [String]
        
    var body: some View {
        VStack {
            Button(action: {
                stack.append("2")
            }, label: {
                Text("다음 2페이지로")
            })
//            NavigationLink("다음 2페이지") {
//                PageTwoView(stack: $stack)
//            }
        }
    }
}

//#Preview {
//    PageOneView(stack: $stack)
//}
