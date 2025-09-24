//
//  TCA_Store.swift
//  TuistSwiftUIApp
//
//  Created by 윤해수 on 9/23/25.
//

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

// MARK: - 시트(바인딩 Bool) 기능
@Reducer
struct SheetToggleFeature {
    @ObservableState
    struct State: Equatable {
        var isSheetPresented: Bool = false
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case setSheet(isPresented: Bool)
    }
    
    private enum CancelID { case load }

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .binding:
                    return .none
                case .setSheet(isPresented: true):
                    state.isSheetPresented = true
                    return .none
                        .cancellable(id: CancelID.load)
                case .setSheet(isPresented: false):
                    state.isSheetPresented = false
                    return .none
                        .cancellable(id: CancelID.load)
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
        var sheetToggle = SheetToggleFeature.State()
    }

    enum Action {
        case counter(CountersFeature.Action)
        case globalAlert(GlobalAlertFeature.Action)
        case sheetToggle(SheetToggleFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.counter, action: \.counter) { CountersFeature() }
        Scope(state: \.globalAlert, action: \.globalAlert) { GlobalAlertFeature() }
        Scope(state: \.sheetToggle, action: \.sheetToggle) { SheetToggleFeature() }
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

            case .counter, .globalAlert, .sheetToggle:
                return .none
            }
        }
    }
}
