//
//  CustomAlertResultView.swift
//  ViewModifier
//
//  Created by 윤해수 on 6/25/24.
//

import SwiftUI

struct CustomAlertResultView: View {
    @State var isShow = false
    @State var title: String
    @State var firstaction: String
    
    var body: some View {
        VStack {
            TextField("타이틀", text: $title)
                .textFieldStyle()
            
            TextField("버튼", text: $firstaction)
                .textFieldStyle()
            
            Button("알림창 띄우기") {
                isShow = true
            }
        }
        .customAlertSytle(isShow: $isShow, title: title, firstAction: firstaction)
    }
}

#Preview {
    CustomAlertResultView(isShow: false, title: "", firstaction: "")
}
