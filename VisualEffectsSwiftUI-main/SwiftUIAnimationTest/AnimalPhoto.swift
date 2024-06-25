//
//  AnimalPhoto.swift
//  SwiftUIAnimationTest
//
//  Created by 한수빈 on 6/19/24.
//

import SwiftUI

struct AnimalPhoto: View {
    let image: String
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .aspectRatio(contentMode: .fill)
                .clipShape(.rect(cornerRadius: 15))
            
        }
    }
}

#Preview {
    AnimalPhoto(image:"Penguin")
}
