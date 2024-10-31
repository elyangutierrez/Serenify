//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/30/24.
//

import SwiftUI

struct ExerciseEightView: View {
    
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
                    Text("Rainbow")
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
    ExerciseEightView(isPresented: .constant(true), backgroundColor: "pastelGreen")
}
