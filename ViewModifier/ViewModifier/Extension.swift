//
//  Extension.swift
//  ViewModifier
//
//  Created by 윤해수 on 6/24/24.
//

import SwiftUI

extension View {
    func textFieldStyle() -> some View {
        modifier(TextFieldStyleModifier())
    }
    
    func alertStyle(isShow: Binding<Bool>, title: String, firstAction: String) -> some View {
        modifier(AlertStyleModifier(isShow: isShow, title: title, firstAction: firstAction))
    }
    
    func customAlertSytle(isShow: Binding<Bool>, title: String, firstAction: String) -> some View {
        modifier(CustomAlertModifier(isShow: isShow, title: title, firstAction: firstAction))
    }
    
    func customModifierClass(userViewModel: UserViewModel, arrayNumber: Int) -> some View {
        modifier(CustomModifierClass(userViewModel: userViewModel, arrayNumber: arrayNumber))
    }
}
