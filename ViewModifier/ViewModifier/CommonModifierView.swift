//
//  CommonModifierView.swift
//  ViewModifier
//
//  Created by 윤해수 on 6/24/24.
//

import SwiftUI

struct CommonModifierView: View {
    @State var firstText: String = ""
    @State var secondText: String = ""
    @State var thirdText: String = ""
    @State var fourthText: String = ""
    @State var fifthText: String = ""
    @State var isShow = false
    
    var body: some View {
        VStack {
            TextField("텍스트 입력", text: $firstText)
                .textFieldStyle()
            
            TextField("텍스트 입력", text: $secondText)
                .textFieldStyle()
            
            TextField("텍스트 입력", text: $thirdText)
                .textFieldStyle()
            
            TextField("텍스트 입력", text: $fourthText)
                .textFieldStyle()
            
            TextField("텍스트 입력", text: $fifthText)
                .textFieldStyle()
            
            Button("알림창 띄우기") {
                isShow = true
            }
        }
        .padding()
        .alertStyle(isShow: $isShow, title: firstText, firstAction: secondText)
    }
}

#Preview {
    CommonModifierView()
}
