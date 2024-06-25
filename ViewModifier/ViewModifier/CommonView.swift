//
//  CommonView.swift
//  ViewModifier
//
//  Created by 윤해수 on 6/24/24.
//

import SwiftUI

struct CommonView: View {
    @State var firstText: String = ""
    @State var secondText: String = ""
    @State var thirdText: String = ""
    @State var fourthText: String = ""
    @State var fifthText: String = ""
    @State var isShow = false
    
    var body: some View {
        VStack {
            TextField("텍스트 입력", text: $firstText)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray)
                )
            
            TextField("텍스트 입력", text: $secondText)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray)
                )
            
            TextField("텍스트 입력", text: $thirdText)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray)
                )
            
            TextField("텍스트 입력", text: $fourthText)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray)
                )
            
            TextField("텍스트 입력", text: $fifthText)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray)
                )
            
            Button("알림창") {
                isShow = true
            }
        }
        .padding()
        .alert("알림", isPresented: $isShow) {
            Text("test")
        }
    }
}

#Preview {
    CommonView()
}
