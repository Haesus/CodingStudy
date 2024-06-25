//
//  GenericModifierView.swift
//  ViewModifier
//
//  Created by 윤해수 on 6/25/24.
//

import SwiftUI

struct GenericModifierView: View {
    @ObservedObject var adultUser = UserViewModel()
    
    var body: some View {
        VStack {
            Text("성인")
                .customModifierClass(userViewModel: adultUser, arrayNumber: 0)
            
            Text("미성년자")
                .customModifierClass(userViewModel: adultUser, arrayNumber: 1)
        }
        .padding()
        .onAppear {
            adultUser.addAdultUser()
        }
    }
}

#Preview {
    GenericModifierView()
}
