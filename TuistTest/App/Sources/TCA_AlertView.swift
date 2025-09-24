//
//  TCA_AlertView.swift
//  TuistSwiftUIApp
//
//  Created by 윤해수 on 9/22/25.
//

import ComposableArchitecture
import SwiftUI

struct CounterPanelView: View {
    let store: StoreOf<CountersFeature>

    struct LocalState: Equatable {
        var number: Int
        var gradeClass: Int?
        var name: String
    }

    var body: some View {
        WithPerceptionTracking {
            WithViewStore(store, observe: { LocalState(number: $0.number, gradeClass: $0.gradeClass, name: $0.name) }) { vs in
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

struct SheetToggleHostView: View {
    @Perception.Bindable var store: StoreOf<SheetToggleFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 8) {
                Button("시트 열기") { store.send(.setSheet(isPresented: true)) }
            }
            .sheet(isPresented: $store.isSheetPresented) {
//            .sheet(isPresented: $store.isSheetPresented.sending(\.setSheet)) {
                WithPerceptionTracking {
                    VStack(spacing: 16) {
                        Text("시트 내용과 시트에 연결된 Bool 값: " + (store.isSheetPresented ? "참" : "거짓")).font(.headline)
                        Button("닫기") { store.send(.setSheet(isPresented: false)) }
                    }
                    .padding()
                    .detentsIfAvailable()
                }
            }
        }
    }
}

extension View {
    @ViewBuilder
    func detentsIfAvailable() -> some View {
        if #available(iOS 16.0, *) {
            self.presentationDetents([.medium, .large])
        } else {
            self
        }
    }
}

struct TCA_AlertView: View {
    let store: StoreOf<ParentFeature>

    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 16) {
                Text("부모에서 표시(시트): " + (store.sheetToggle.isSheetPresented ? "열림" : "닫힘"))
                CounterPanelView(store: store.scope(state: \.counter, action: \.counter))
                GlobalAlertHostView(store: store.scope(state: \.globalAlert, action: \.globalAlert))
                SheetToggleHostView(store: store.scope(state: \.sheetToggle, action: \.sheetToggle))
            }
            .padding()
        }
    }
}

#Preview {
    TCA_AlertView(
        store: Store(initialState: ParentFeature.State()) {
            ParentFeature()
        }
    )
}
