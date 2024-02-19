//
//  ObjectViewModel.swift
//  ObservedObjectAndStateObject
//
//  Created by 윤해수 on 12/6/23.
//

import Foundation

class ObjectViewModel: ObservableObject {
    @Published var number = 0

    func upNumber() {
        number += 1
    }
}
