//
//  AnimalScrollView.swift
//  SwiftUIAnimationTest
//
//  Created by 한수빈 on 6/19/24.
//

import SwiftUI

struct AnimalScrollView: View {
    let animals = ["Penguin","Elephant","Flamingo","Whale","Bear"]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16) {
                ForEach(animals, id: \.self) { animal in
                    VStack(spacing: 8) {
                        ZStack {
                            AnimalPhoto(image: animal)
                                .scrollTransition(
                                    axis: .horizontal
                                ) { content, phase in
                                    return content
                                        .offset(x: phase.value * -250)
                                }
                        }
                        .containerRelativeFrame(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 32))
                        Text(animal)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                    }
                }
                .scrollTargetLayout()
            }
            .contentMargins(.horizontal, 32)
            .scrollTargetBehavior(.paging)
        }
        .frame(width: 300,height: 700)
    }
}


struct AnimalScrollView2: View {
    let animals = ["Penguin","Elephant","Flamingo","Whale","Bear"]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 22) {
                ForEach(animals, id: \.self) { animal in
                    AnimalPhoto(image: animal)
                        .scrollTransition(
                            axis: .horizontal
                        ) { content, phase in
                            content
                                .rotationEffect(.degrees(phase.value * 20.5))
                                .offset(y: phase.isIdentity ? 0 : 8)
                        }
                }
                .containerRelativeFrame(.horizontal)
                .clipShape(RoundedRectangle(cornerRadius: 32))
            }.scrollTargetLayout()
        }
        .contentMargins(.horizontal, 44)
        .scrollTargetBehavior(.paging)
    }
}

#Preview {
    AnimalScrollView()
}
#Preview {
    AnimalScrollView2()
}
