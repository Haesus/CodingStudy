//
//  ContentView.swift
//  StateAndBindingStudy
//
//  Created by 윤해수 on 11/27/23.
//

import SwiftUI

struct StateView: View {
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack {
            PlayButton(isPlaying: $isPlaying)
        }
    }
}

struct PlayButton: View {
    @Binding var isPlaying: Bool
    
    var body: some View {
        Button(isPlaying ? "Pause" : "Play") {
            isPlaying.toggle()
        }
    }
}

#Preview {
    StateView()
}
