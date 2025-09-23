//
//  TCA_AlertView.swift
//  TuistSwiftUIApp
//
//  Created by 윤해수 on 9/22/25.
//

import SwiftUI
import ComposableArchitecture
import Perception

// MARK: - 카운터 기능
@Reducer
struct CountersFeature {
    @ObservableState
    struct State: Equatable {
        var number = 0
        var gradeClass: Int?
        var name = ""
    }
    
    enum Action {
        case increment
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .increment:
                state.number += 1
                return .none
            }
        }
    }
}

// MARK: - 알림 기능
@Reducer
struct GlobalAlertFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var alert: AlertState<Action.Alert>?
        var currentKind: Kind?
    }

    enum Action {
        case showIncrementConfirm
        case changeClassGrade
        case alert(PresentationAction<Alert>)
        case delegate(Delegate)

        enum Alert: Equatable {
            case confirm, cancel
        }
        
        enum Delegate: Equatable {
            case confirmedIncrement
            case confirmedIncrementClass
            case confirmedDecrementClass
        }
    }

    enum Kind: Equatable {
        case incrementCounter
        case changeClassGrade
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .showIncrementConfirm:
                    state.alert = AlertState {
                        TextState("주의")
                    } actions: {
                        ButtonState(role: .cancel, action: .cancel) { TextState("취소") }
                        ButtonState(action: .confirm) { TextState("확인") }
                    } message: {
                        TextState("증가를 진행하시겠사옵니까?")
                    }
                    state.currentKind = .incrementCounter
                    return .none

                case .changeClassGrade:
                    state.alert = AlertState {
                        TextState("등급 변경")
                    } actions: {
                        ButtonState(role: .cancel, action: .cancel) { TextState("감소") }
                        ButtonState(action: .confirm) { TextState("증가") }
                    } message: {
                        TextState("등급을 변경하시겠습니까? 확인=증가, 취소=감소")
                    }
                    state.currentKind = .changeClassGrade
                    return .none

                case .alert(.presented(.confirm)):
                    let kind = state.currentKind
                    state.alert = nil
                    state.currentKind = nil
                    switch kind {
                    case .incrementCounter?:
                        return .send(.delegate(.confirmedIncrement))
                    case .changeClassGrade?:
                        return .send(.delegate(.confirmedIncrementClass))
                    default:
                        return .none
                    }

                case .alert(.presented(.cancel)):
                    let kind = state.currentKind
                    state.alert = nil
                    state.currentKind = nil
                    switch kind {
                    case .changeClassGrade?:
                        return .send(.delegate(.confirmedDecrementClass))
                    default:
                        return .none
                    }

                case .alert:
                    return .none

                case .delegate:
                    return .none
            }
        }
    }
}

// MARK: - 카운터 + 알림 기능
@Reducer
struct ParentFeature {
    @ObservableState
    struct State: Equatable {
        var counter = CountersFeature.State()
        var globalAlert = GlobalAlertFeature.State()
    }

    enum Action {
        case counter(CountersFeature.Action)
        case globalAlert(GlobalAlertFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.counter, action: \.counter) { CountersFeature() }
        Scope(state: \.globalAlert, action: \.globalAlert) { GlobalAlertFeature() }
        Reduce { state, action in
            switch action {
            case .globalAlert(.delegate(.confirmedIncrement)):
                return .send(.counter(.increment))

            case .globalAlert(.delegate(.confirmedIncrementClass)):
                let current = state.counter.gradeClass ?? 0
                state.counter.gradeClass = current + 1
                return .none

            case .globalAlert(.delegate(.confirmedDecrementClass)):
                let current = state.counter.gradeClass ?? 0
                state.counter.gradeClass = max(0, current - 1)
                return .none

            case .counter, .globalAlert:
                return .none
            }
        }
    }
}


struct CounterPanelView: View {
    let store: StoreOf<CountersFeature>

    struct LocalState: Equatable {
        var number: Int
        var gradeClass: Int?
        var name: String
    }

    var body: some View {
        WithViewStore(store, observe: { LocalState(number: $0.number, gradeClass: $0.gradeClass, name: $0.name) }) { vs in
            WithPerceptionTracking {
                VStack(spacing: 8) {
                    Text("당신의 이름은: \(vs.name)")
                    Text(vs.gradeClass.map { "현재 등급은 \($0)입니다." } ?? "현재 등급은 존재하지 않습니다.")
                    Text("카운트: \(vs.number)")
                        .font(.title3)
                }
            }
        }
    }
}

struct GlobalAlertHostView: View {
    let store: StoreOf<GlobalAlertFeature>

    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 8) {
                Button("증가 확인 요청") {
                    store.send(.showIncrementConfirm)
                }
                Button("등급 변경") {
                    store.send(.changeClassGrade)
                }
            }
            .alert(
                store: store.scope(state: \.$alert, action: \.alert)
            )
        }
    }
}

struct TCA_AlertView: View {
    let store: StoreOf<ParentFeature>

    var body: some View {
        VStack(spacing: 16) {
            CounterPanelView(store: store.scope(state: \.counter, action: \.counter))
            GlobalAlertHostView(store: store.scope(state: \.globalAlert, action: \.globalAlert))
        }
        .padding()
    }
}

#Preview {
    TCA_AlertView(
        store: Store(initialState: ParentFeature.State()) {
            ParentFeature()
        }
    )
}
