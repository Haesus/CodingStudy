//
//  GradientScrollView.swift
//  SwiftUIAnimationTest
//
//  Created by 한수빈 on 6/20/24.
//

import SwiftUI

struct GradientScrollView: View {
    var groceries = ["apple", "banana", "carrot", "brocolli", "peach", "celery", "tomato","cucumber","apple"]
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 16) {
                ForEach(groceries, id: \.self) { grocery in
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(.purple)
                            .frame(height: 100)
                            .visualEffect { content, proxy in
                                content
                                    .hueRotation(Angle(degrees: proxy.frame(in: .global).origin.y / 10 ))
                            }

                        Text(grocery)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .shadow(radius: 5)
                    }
                }
            }
        }
    }
}

#Preview {
    GradientScrollView()
}

