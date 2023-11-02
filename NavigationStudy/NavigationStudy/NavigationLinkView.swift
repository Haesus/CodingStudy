//
//  NavigationLinkView.swift
//  NavigationStudy
//
//  Created by 윤해수 on 11/2/23.
//

import SwiftUI

struct NavigationLinkView: View {

    private var str: String = "변수를 받아서 페이지 구성 가능"
    
    var body: some View {
        NavigationStack {
            NavigationLink {
                NavigationLinkOneView()
            } label: {
                Text("첫번째 페이지로 이동합니다.")
            }
            NavigationLink(str) {
                NavigationLinkOneView()
            }
            .foregroundStyle(Color.black)
        }
    }
}

#Preview {
    NavigationLinkView()
}
