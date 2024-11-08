//
//  SwiftUIView 3.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/7/24.
//

import SwiftUI

struct MeditationThreeView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("3")
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Circle()
                            .fill(Color("darkerPastelGreen"))
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
    MeditationThreeView()
}
