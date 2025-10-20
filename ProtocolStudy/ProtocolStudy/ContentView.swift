//
//  ContentView.swift
//  ProtocolStudy (TMA+TCA Sample)
//
//  This file demonstrates a minimal App–Feature–Domain–Core design
//  where Feature is implemented with TCA. Tuist is not required for
//  this single-file sample; modules are indicated by MARK sections.
//

import SwiftUI
import Foundation
import ComposableArchitecture

// =============================================================
// MARK: - Domain (Pure business models & contracts)
// =============================================================

public struct User: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let name: String
    public init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}

public protocol UserRepository: Sendable {
    func fetchUsers() async throws -> [User]
}

// =============================================================
// MARK: - Core (Infra: DTO, DataSource, Repository Impl)
// =============================================================

public struct UserDTO: Decodable, Equatable, Sendable {
    public let id: String
    public let full_name: String
}

public extension UserDTO {
    func toDomain() -> User {
        User(id: UUID(uuidString: id) ?? .init(), name: full_name)
    }
}

public protocol UserRemoteDataSource: Sendable {
    func fetch() async throws -> [UserDTO]
}

public final class MockUserRemoteDataSource: UserRemoteDataSource {
    public init() {}
    public func fetch() async throws -> [UserDTO] {
        try await Task.sleep(nanoseconds: 300_000_000) // 0.3s
        return [
            .init(id: "11111111-1111-1111-1111-111111111111", full_name: "홍길동"),
            .init(id: "22222222-2222-2222-2222-222222222222", full_name: "임꺽정"),
            .init(id: "33333333-3333-3333-3333-333333333333", full_name: "태그 주인님")
        ]
    }
}

public final class UserRepositoryImpl: UserRepository {
    private let remote: any UserRemoteDataSource
    public init(remote: any UserRemoteDataSource) { self.remote = remote }
    public func fetchUsers() async throws -> [User] {
        let dtos = try await remote.fetch()
        return dtos.map { $0.toDomain() }
    }
}

// =============================================================
// MARK: - Feature (TCA Reducer / State / Action)
// =============================================================

@Reducer
struct UserListFeature {
    @ObservableState
    public struct State: Equatable, Sendable {
        var child = ChildFeature.State()
        var isSheetToggle = false
        public var users: [User] = []
        public var isLoading = false
        public var errorMessage: String?
        public init() {}
    }
    
    public enum Action: Sendable, BindableAction {
        case binding(BindingAction<State>)
        case isSheetToggle
        case onAppear
        case refreshTapped
        case _usersResponse(Result<[User], Error>)
        case child(ChildFeature.Action)
    }

    private let repository: any UserRepository
    public init(repository: any UserRepository) { self.repository = repository }

    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Scope(state: \.child, action: \.child) {
            ChildFeature()
        }
        
        Reduce { state, action in
            switch action {
                case .isSheetToggle:
                    state.isSheetToggle = true
                    print(state.isSheetToggle)
                    return .none
                case .onAppear:
                    state.isLoading = true
                    state.errorMessage = nil
                    return .run { [repository] send in
                        do {
                            let users = try await repository.fetchUsers()
                            await send(._usersResponse(.success(users)))
                        } catch {
                            await send(._usersResponse(.failure(error)))
                        }
                    }
                    
                case .refreshTapped:
                    state.isLoading = true
                    state.errorMessage = nil
                    return .run { [repository] send in
                        do {
                            let users = try await repository.fetchUsers()
                            await send(._usersResponse(.success(users)))
                            await send(.child(ChildFeature.Action.refreshText))
                        } catch {
                            await send(._usersResponse(.failure(error)))
                        }
                    }
                    
                case let ._usersResponse(result):
                    state.isLoading = false
                    switch result {
                        case .success(let users):
                            state.users = users
                            state.errorMessage = nil
                        case .failure(let error):
                            state.errorMessage = String(describing: error)
                    }
                    return .none
                    
                case .binding, .child:
                    return .none
            }
        }
    }
}

@Reducer
struct ChildFeature {
    @ObservableState
    struct State: Equatable, Sendable {
        var refreshText: String = "test"
    }
    
    enum Action: Sendable {
        case refreshText
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                case .refreshText:
                    state.refreshText = "새로고쳤습니다."
                    return .none
            }
        }
    }
}

struct UserListView: View {
    @Bindable var store: StoreOf<UserListFeature>
    public init(store: StoreOf<UserListFeature>) { self.store = store }

    var body: some View {
        NavigationStack {
            VStack {
                ChildView(
                    store:store.scope(
                        state: \.child,
                        action: \.child
                    )
                )
                .frame(height: 200)
                
                Text("\(store.isSheetToggle)")
                
                Button {
                    store.send(.isSheetToggle)
                } label: {
                    Text("시트열기")
                }
                
                if store.isLoading {
                    ProgressView("불러오는 중…")
                } else if let message = store.errorMessage {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                        Text(message)
                        Button("다시 시도") { store.send(.refreshTapped) }
                    }
                } else {
                    List(store.users) { user in
                        Text(user.name)
                    }
                }
            }
            .navigationTitle("사용자 목록")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button { store.send(.refreshTapped) } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .sheet(isPresented: $store.isSheetToggle) {
                Text("테스트")
            }
        }
        .task { store.send(.onAppear) }
    }
}

struct ChildView: View {
    let store: StoreOf<ChildFeature>
    public init(store: StoreOf<ChildFeature>) { self.store = store }
    
    var body: some View {
        Text(store.refreshText)
    }
}

struct ContentView: View {
    var body: some View {
            let repo = UserRepositoryImpl(remote: MockUserRemoteDataSource())
            UserListView(
                store: Store(initialState: .init()) {
                    UserListFeature(repository: repo)
                }
            )
    }
}

// =============================================================
// MARK: - SwiftUI Preview (optional)
// =============================================================
#Preview {
    let repo = UserRepositoryImpl(remote: MockUserRemoteDataSource())
    return UserListView(
        store: Store(initialState: .init()) {
            UserListFeature(repository: repo)
        }
    )
}
