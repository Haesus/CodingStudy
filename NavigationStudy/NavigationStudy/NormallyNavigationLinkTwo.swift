//
//  NormallyNavigationLinkOne.swift
//  NavigationStudy
//
//  Created by 윤해수 on 6/16/24.
//

import SwiftUI

struct NormallyNavigationLinkTwo: View {
    var body: some View {
        NavigationLink {
            NormallyNavigationLinkThree()
        } label: {
            Text("세번째 뷰로 이동")
        }
        .navigationTitle("두번째 스택 제목")
    }
}

#Preview {
    NormallyNavigationLinkTwo()
}
