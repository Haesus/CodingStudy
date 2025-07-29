//
//  ContentView.swift
//  KeyChainTest
//
//  Created by 윤해수 on 7/29/25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue: String = ""
    @State private var loadedValue: String = ""
    @State private var functionStatusSave: Bool? = nil
    @State private var functionStatusDelete: Bool? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text(functionStatusSave.map { $0 ? "✅ 저장 성공!" : "❌ 저장 실패" } ?? "⏳ 아직 저장 안됨")
                .foregroundColor( functionStatusSave.map {  $0 ? .green : .red } ?? .gray )
            Text(functionStatusDelete.map { $0 ? "✅ 삭제 성공!" : "❌ 삭제 실패" } ?? "⏳ 아직 삭제 안됨")
                .foregroundColor( functionStatusDelete.map {  $0 ? .green : .red } ?? .gray )
            
            TextField("Enter value", text: $inputValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            HStack {
                Button("Save to Keychain") {
                    functionStatusSave = KeyChainManager.shared.save(key: "userInput", value: inputValue)
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1)
                }

                Button("Load from Keychain") {
                    if let loaded = KeyChainManager.shared.load(key: "userInput") {
                        loadedValue = loaded
                    }
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1)
                }

                Button("Delete from Keychain") {
                    functionStatusDelete = KeyChainManager.shared.delete(key: "userInput")
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1)
                }
            }

            VStack {
                Text("Loaded:")
                    .foregroundColor(.gray)
                
                Text(loadedValue)
                    .foregroundStyle(.primary)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
