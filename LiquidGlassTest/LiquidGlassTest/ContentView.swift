//
//  ContentView.swift
//  LiquidGlassTest
//
//  Created by 윤해수 on 9/18/25.
//

import SwiftUI

struct ContentView: View {
    @State var searchString: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.green)
                
                VStack {
                    Button {
                        
                    } label: {
                        Text("LiquidGlassTest")
                            .padding()
                            .background(.red)
                    }
                    
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            
                        } label: {
                            Text("Leading")
                                .padding()
                        }
                        .background(.red)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            
                        } label: {
                            Text("Trailing1")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            
                        } label: {
                            Text("Trailing2")
                        }
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            
                        } label: {
                            Text("bottom1")
                        }
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            
                        } label: {
                            Text("bottom1")
                        }
                    }
                }
                .searchable(text: $searchString, prompt: "Search")
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
//    NavigationStack {
        ContentView()
//    }
}
