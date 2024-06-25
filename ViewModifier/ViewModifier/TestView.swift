//
//  TestView.swift
//  ViewModifier
//
//  Created by 윤해수 on 6/25/24.
//

import SwiftUI

struct TestView: View {
    @State private var isShowing = false
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap Me") {
            withAnimation {
                self.animationAmount += 360
            }
        }
        .padding(40)
        .background(Color.green)
        .foregroundColor(.white)
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        .onAppear {
            withAnimation {
                self.animationAmount += 360
            }
        }
    }
}

#Preview {
    TestView()
}
