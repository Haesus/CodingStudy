//
//  MeshGradientView.swift
//  SwiftUIAnimationTest
//
//  Created by 한수빈 on 6/24/24.
//

import SwiftUI

@available(iOS 18.0, *)
struct MeshGradientView: View {
    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                [0.0, 0.3], [0.7, 0.9], [1.0, 0.5],
                [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
            ],
            colors: [
                .black, .black, .black,
                .blue, .blue, .blue,
                .green, .green, .green
            ]
        )
        .ignoresSafeArea()
    }
}

@available(iOS 18.0, *)
#Preview {
    MeshGradientView()
}
