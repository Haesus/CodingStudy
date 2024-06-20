//
//  NormallyNavigationLinkTwo.swift
//  NavigationStudy
//
//  Created by 윤해수 on 6/16/24.
//

import SwiftUI

struct NormallyNavigationLinkThree: View {
    var body: some View {
            NavigationLink {
                NormallyNavigationLinkFour()
            } label: {
                Text("네번째 네비게이션 뷰로 가기")
            }
        .navigationTitle("세번째 스택 제목")
    }
}

#Preview {
    NormallyNavigationLinkThree()
}
