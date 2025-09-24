//
//  TCA_BindingView.swift
//  TuistSwiftUIApp
//
//  Created by 윤해수 on 9/24/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct PresentAndLoad {
    @ObservableState
    struct State: Equatable {
        var isSheetPresented = false
    }
    
    enum Action {
        case setSheet(isPresented: Bool)
        case setSheetIsPresentedDelayCompleted
    }
    
//    @Dependency(\.continuousClock) var clock
    private enum CancelID { case load }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                case .setSheet(isPresented: true):
                    state.isSheetPresented = true
//                    return .run { send in
//                        try await self.clock.sleep(for: .seconds(1))
//                        await send(.setSheetIsPresentedDelayCompleted)
//                    }
//                    .cancellable(id: CancelID.load)
                    
                    return .none
                        .cancellable(id: CancelID.load)
                    
                case .setSheet(isPresented: false):
                    state.isSheetPresented = false
//                    return .cancel(id: CancelID.load)
                    
                    return .none
                        .cancellable(id: CancelID.load)
                    
                case .setSheetIsPresentedDelayCompleted:
                    return .none
            }
        }
    }
}

struct TCA_BindingView: View {
    @Perception.Bindable var store: StoreOf<PresentAndLoad>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Button("시트 열기") { store.send(.setSheet(isPresented: true)) }
            }
            .sheet(isPresented: $store.isSheetPresented.sending(\.setSheet)) {
                VStack(spacing: 16) {
//                    Text("시트 내용과 시트에 연결된 Bool 값: \(store.isSheetPresented ? "참" : "거짓")").font(.headline)
                    Button("닫기") { store.send(.setSheet(isPresented: false)) }
                }
                .padding()
                .detentsIfAvailable()
            }
        }
    }
}

#Preview {
    NavigationView {
        TCA_BindingView(
            store: Store(initialState: PresentAndLoad.State()) {
                PresentAndLoad()
            }
        )
    }
}
