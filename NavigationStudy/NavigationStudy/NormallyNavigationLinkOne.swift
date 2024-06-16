//
//  NormallyNavigation.swift
//  NavigationStudy
//
//  Created by 윤해수 on 6/16/24.
//

import SwiftUI

struct NormallyNavigationLinkOne: View {
    var body: some View {
        NavigationStack {
            NavigationLink("두번째 뷰로 이동") {
                NormallyNavigationLinkTwo()
            }
            .navigationTitle("첫번째 스택 제목")
        }
    }
}

#Preview {
    NormallyNavigationLinkOne()
}
