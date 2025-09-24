import SwiftUI
import ComposableArchitecture

@main
struct SearchApp: App {
    static let store = Store(initialState: ParentFeature.State()) {
        ParentFeature()
            ._printChanges()
    }
    static let store1 = Store(initialState: PresentAndLoad.State()) {
        PresentAndLoad()
            ._printChanges()
    }
//    static let store = Store(initialState: Search.State()) {
//        Search()
//            ._printChanges()
//    }
    
    var body: some Scene {
        WindowGroup {
//            TCA_BindingView(store: Self.store1)
            TCA_AlertView(store: Self.store)
//            SearchView(store: Self.store)
        }
    }
}

#Preview {
    TCA_AlertView(store: Store(initialState: ParentFeature.State()) {
        ParentFeature()
        #if DEBUG
            ._printChanges()
        #endif
    })
}

//struct TuistSwiftUIApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
