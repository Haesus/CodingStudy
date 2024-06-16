//
//  NavigationViewTwo.swift
//  NavigationStudy
//
//  Created by 윤해수 on 6/16/24.
//

import SwiftUI

struct NavigationViewTwo: View {
    var body: some View {
        NavigationView {
            NavigationLink("세번째 네비게이션뷰 이동") {
                NavigationViewThree()
            }
            .navigationTitle("두번째 네비게이션뷰")
        }
    }
}

#Preview {
    NavigationViewTwo()
}
