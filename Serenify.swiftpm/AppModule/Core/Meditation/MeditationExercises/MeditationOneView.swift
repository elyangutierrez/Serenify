//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/7/24.
//

import SwiftUI

struct MeditationOneView: View {
    
    @Environment(\.dismiss) var dismiss
    var soundPlayer: SoundPlayer
    
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    soundPlayer.playerHandler()
                }) {
                    Text("Play!")
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("1")
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
    MeditationOneView(soundPlayer: SoundPlayer())
}
