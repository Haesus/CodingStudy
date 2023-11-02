//
//  NavigationLinkOneView.swift
//  NavigationStudy
//
//  Created by 윤해수 on 11/2/23.
//

import SwiftUI

struct NavigationLinkOneView: View {
    var body: some View {
        NavigationLink {
            NavigationLinkTwoView()
        } label: {
            Text("두번째 페이지로 이동합니다.")
        }
    }
}

#Preview {
    NavigationLinkOneView()
}
