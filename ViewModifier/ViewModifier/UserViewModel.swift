//
//  UserViewModel.swift
//  ViewModifier
//
//  Created by 윤해수 on 6/25/24.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: [User] = []
    
    init() {
        addAdultUser()
    }
    
    func addAdultUser() {
        user.append(User(name: "Yoon", age: 20))
        user.append(User(name: "Park", age: 17))
    }
}
