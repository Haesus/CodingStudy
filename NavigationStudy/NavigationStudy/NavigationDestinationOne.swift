//
//  NavigationDestinationOne.swift
//  NavigationStudy
//
//  Created by 윤해수 on 6/16/24.
//

import SwiftUI

struct NavigationDestinationOne: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("1", value: "1")
                NavigationLink("2", value: "2")
                NavigationLink("3", value: "3")
            }
            .navigationDestination(for: String.self) { str in
                NavigationDestinationTwo(str: str)
            }
            .navigationTitle("String")
        }
    }
}

#Preview {
    NavigationDestinationOne()
}
