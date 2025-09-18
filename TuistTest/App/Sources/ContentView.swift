import SwiftUI
import ComposableArchitecture
import Perception

struct CounterFeature: Reducer {
    @ObservableState
    struct State: Equatable {
        var count: Int = 0
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case increment
        case decrement
    }

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .increment:
                state.count += 1
                return .none
            case .decrement:
                state.count -= 1
                return .none
            }
        }
    }
}

struct ContentView: View {
    @Perception.Bindable var store: StoreOf<CounterFeature>
    
    init() {
        self.store = Store(initialState: CounterFeature.State()) { CounterFeature() }
    }
    
    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 12) {
                Text("Count: \(store.count)")
                    .font(.title.bold())
                                
                // 바인딩 예시 1: Stepper
                Stepper("Step: \(store.count)", value: $store.count)

                // 바인딩 예시 2: TextField로 숫자 입력 (간단 변환 예)
                TextField("수 입력", value: $store.count, format: .number)
                  .textFieldStyle(.roundedBorder)
                  .keyboardType(.numberPad)

                HStack(spacing: 20) {
                    Button("-") { store.send(.decrement) }
                        .font(.largeTitle)
                    Button("+") { store.send(.increment) }
                        .font(.largeTitle)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
