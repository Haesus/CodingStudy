//
//  Modifier.swift
//  ViewModifier
//
//  Created by 윤해수 on 6/24/24.
//

import SwiftUI

struct TextFieldStyleModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray)
            )
    }
}

struct AlertStyleModifier: ViewModifier {
    @Binding var isShow: Bool
    
    var title: String
    var firstAction: String
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $isShow) {
                Text(firstAction)
            }
    }
}

struct CustomAlertModifier: ViewModifier {
    @Binding var isShow: Bool
    
    var title: String
    var firstAction: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isShow {
                CustomAlertView(isShow: $isShow, title: title, firstAction: firstAction)
            }
        }
    }
}

struct CustomModifierClass<T>: ViewModifier where T: UserViewModel {
    let userViewModel: T
    let arrayNumber: Int
    
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 50)
            .padding()
            .background(userViewModel.user[arrayNumber].age >= 18 ? Color.green : Color.red)
            .cornerRadius(8)
    }
}
