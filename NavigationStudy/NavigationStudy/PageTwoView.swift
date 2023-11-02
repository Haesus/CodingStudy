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
            Text("이곳은 두번째 네비게이션을 타고 온 곳입니다.")
            
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
    }
}

//#Preview {
//    PageTwoView(stack: $stack)
//}
