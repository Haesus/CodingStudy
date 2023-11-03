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
            Text("이곳은 첫번째 네비게이션을 타고 온 곳입니다.")
            
            Button(action: {
                stack.append("2")
            }, label: {
                Text("다음 2페이지로")
            })
        }
    }
}

//#Preview {
//    PageOneView(stack: $stack)
//}
