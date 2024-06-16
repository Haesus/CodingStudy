//
//  NavigationView.swift
//  NavigationStudy
//
//  Created by 윤해수 on 6/16/24.
//

import SwiftUI

struct NavigationViewOne: View {
    var body: some View {
        NavigationView {
            NavigationLink("두번째 네비게이션뷰 이동") {
                NavigationViewTwo()
//                    .navigationTitle("두번째 네비게이션뷰")
            }
            .navigationTitle("첫번째 네비게이션뷰")
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    NavigationViewOne()
}
