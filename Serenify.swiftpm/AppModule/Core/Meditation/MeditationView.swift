//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/29/24.
//

import SwiftUI

struct MeditationView: View {
    
    @State private var soundPlayer = SoundPlayer()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Button(action: {
                        soundPlayer.getSound(name: "forestSoundEffect")
                        soundPlayer.playerHandler()
                    }) {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(.green)
                            .frame(width: 200, height: 100)
                            .overlay {
                                Text("Forest")
                            }
                    }
                    
                    Button(action: {
                        //
                    }) {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(.blue)
                            .frame(width: 200, height: 100)
                            .overlay {
                                Text("Winter")
                            }
                    }
                    
                    Button(action: {
                        //
                    }) {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(.yellow)
                            .frame(width: 200, height: 100)
                            .overlay {
                                Text("Sunset")
                            }
                    }
                    
                    Button(action: {
                        //
                    }) {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(.pink)
                            .frame(width: 200, height: 100)
                            .overlay {
                                Text("Stream")
                            }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Meditation")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    MeditationView()
}
