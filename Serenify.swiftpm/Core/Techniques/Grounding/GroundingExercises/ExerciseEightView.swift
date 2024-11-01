//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/30/24.
//

import SwiftUI

struct ExerciseEightView: View {
    
    @Binding var isPresented: Bool
    @State private var isPlaying = false
    var backgroundColor: String
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello!")
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
                            .foregroundStyle(Color("darkerPastelGreen"))
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
