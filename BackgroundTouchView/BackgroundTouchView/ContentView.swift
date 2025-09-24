//
//  ContentView.swift
//  BackgroundTouchView
//
//  Created by 윤해수 on 8/13/25.
//

import SwiftUI

struct ContentView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    
    // 포커스 상태 정의
    @FocusState private var focusedField: Field?
    
    // 여러 필드를 구분하기 위한 enum
    enum Field {
        case name
        case email
    }
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("이름 입력", text: $name)
                .textFieldStyle(.roundedBorder)
                .focused($focusedField, equals: .name)
            
            TextField("이메일 입력", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .focused($focusedField, equals: .email)
            
            HStack {
                Button("이름에 포커스") {
                    focusedField = .name
                }
                Button("이메일에 포커스") {
                    focusedField = .email
                }
                Button("포커스 해제") {
                    focusedField = nil
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
