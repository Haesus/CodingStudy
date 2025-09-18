//
//  ReactorKit.swift
//  TuistSwiftUIApp
//
//  Created by 윤해수 on 9/9/25.
//

import Foundation

import ReactorKit
import RxSwift
//import RxCocoa

final class CounterReactor: Reactor {
    enum Action {
        case increment
        case decrement
    }

    enum Mutation {
        case changeValue(Int)
    }

    struct State {
        var value: Int = 0
    }

    let initialState = State()

    func mutate(action: Action) -> Observable<Mutation> {
        print("Reactor.mutate")
        switch action {
        case .increment:
            return .just(.changeValue(currentState.value + 1))
        case .decrement:
            return .just(.changeValue(currentState.value - 1))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        print("Reactor.reduce")
        var newState = state
        switch mutation {
        case let .changeValue(v):
            newState.value = v
        }
        return newState
    }
}

final class ReactorViewModel<R: Reactor>: ObservableObject {
    @Published private(set) var state: R.State
    let reactor: R
    private let disposeBag = DisposeBag()

    init(reactor: R) {
        print("ReactorViewModel.init")
        self.reactor = reactor
        self.state = reactor.initialState

        reactor.state
            .subscribe(onNext: { [weak self] newState in
                self?.state = newState
            })
            .disposed(by: disposeBag)
    }

    func action(_ action: R.Action) {
        print("ReactorViewModel.action")
        reactor.action.onNext(action)
    }
}
