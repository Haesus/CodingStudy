//
//  StateObjectView.swift
//  ObservedObjectAndStateObject
//
//  Created by 윤해수 on 12/6/23.
//

import SwiftUI

struct StateObjectView: View {
    @StateObject var stateObjectViewModel = ObjectViewModel()
    
    var body: some View {
        VStack {
            Text("StateObject")
            Text("ObjectViewModel의 숫자 값 : \(stateObjectViewModel.number)")
            Button("ObjectViewModel Number값 증가") {
                stateObjectViewModel.upNumber()
            }
        }
    }
}

#Preview {
    StateObjectView()
}
