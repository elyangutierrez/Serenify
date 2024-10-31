//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/30/24.
//

import SwiftUI

struct ExerciseFiveView: View {
    
    @Binding var isPresented: Bool
    var backgroundColor: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(backgroundColor)
                    .ignoresSafeArea()
                Text("Hello, World!")
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("5-4-3-2-1")
                        .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Circle()
                            .fill(.black)
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image(systemName: "xmark")
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    ExerciseFiveView(isPresented: .constant(true), backgroundColor: "pastelBlue")
}
