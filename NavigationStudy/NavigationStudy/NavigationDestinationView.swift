//
//  NavigationDestinationView.swift
//  NavigationStudy
//
//  Created by 윤해수 on 11/2/23.
//

import SwiftUI

struct NavigationDestinationView: View {
    @State private var isShowSheet = false
    @State private var isShowSheet1 = false
    @State private var stack: [String] = []
    
    var body: some View {
        NavigationStack(path: $stack) {
            Button(action: {
                stack.append("1")
                print(stack)
            }, label: {
                Text("페이지 1로")
            })
            .navigationDestination(for: String.self) { stack in
                NavigationDestinationViewOne(stack: $stack)
            }
            .toolbar {
                Button("시트") {
                    isShowSheet = true
                }
                Button("풀스크린") {
                    isShowSheet1 = true
                }
            }
            .sheet(isPresented: $isShowSheet) {
                Text("시트페이지")
            }
            .fullScreenCover(isPresented: $isShowSheet1) {
                Text("풀스크린시트 페이지")
            }
        }
    }
}

#Preview {
    NavigationDestinationView()
}
