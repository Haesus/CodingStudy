//
//  NavigationLinkView.swift
//  NavigationStudy
//
//  Created by 윤해수 on 11/2/23.
//

import SwiftUI

struct NavigationLinkView: View {
    
    @State private var stack: [String] = []
    
    private var str: String = "next Page"
    
    var body: some View {
        NavigationStack {
            NavigationLink {
                PageOneView(stack: $stack)
            } label: {
                Text("페이지 1")
            }
            NavigationLink(str) {
                PageOneView(stack: $stack)
            }
            .foregroundStyle(Color.black)
        }
    }
}

#Preview {
    NavigationLinkView()
}
