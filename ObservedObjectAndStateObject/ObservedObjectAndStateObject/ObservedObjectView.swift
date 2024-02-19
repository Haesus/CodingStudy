//
//  ObservedObjectView.swift
//  ObservedObjectAndStateObject
//
//  Created by 윤해수 on 12/6/23.
//

import SwiftUI

struct ObservedObjectView: View {
    @ObservedObject var observedObjectViewModel = ObjectViewModel()
    
    var body: some View {
        VStack {
            Text("ObservedObject")
            Text("ObjectViewModel의 숫자 값 : \(observedObjectViewModel.number)")
            Button("ObjectViewModel Number값 증가") {
                observedObjectViewModel.upNumber()
            }
        }
    }
}

#Preview {
    ObservedObjectView()
}
