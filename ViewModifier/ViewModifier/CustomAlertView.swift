//
//  CustomAlertView.swift
//  ViewModifier
//
//  Created by 윤해수 on 6/25/24.
//

import SwiftUI

struct CustomAlertView: View {
    @Binding var isShow: Bool
    
    @State private var animationAmount = 0.0
    
    var title: String
    var firstAction: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black.opacity(0.5))
                .blur(radius: 0)
                .ignoresSafeArea()
            
            Group {
                Rectangle()
                    .foregroundColor(.blue)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding()
                    .frame(width: 400, height: 300)
                
                VStack {
                    Text(title)
                        .font(.title)
                    
                    Button(firstAction) {
                        isShow = false
                    }
                    .foregroundColor(.black)
                }
            }
            .rotation3DEffect(
                .degrees(animationAmount),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .onAppear {
                withAnimation {
                    self.animationAmount += 1080
                }
            }
            .rotationEffect(.degrees(360))
        }
    }
}

#Preview {
    CustomAlertView(isShow: .constant(true), title: "메세지", firstAction: "확인")
}
