//
//  RxSwiftReactorKitView.swift
//  TuistSwiftUIApp
//
//  Created by 윤해수 on 9/9/25.
//

import SwiftUI

struct RxSwiftReactorKitView: View {
    @StateObject private var viewModel = ReactorViewModel(reactor: CounterReactor())

    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \(viewModel.state.value)")
                .font(.title)
            HStack {
                Button("-") {
                    print("button.decrement")
                    viewModel.action(.decrement) }
                Button("+") {
                    print("button.increment")
                    viewModel.action(.increment) }
            }
            .font(.largeTitle)
        }
        .padding()
    }
}

#Preview {
    RxSwiftReactorKitView()
}
