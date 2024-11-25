//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/29/24.
//

import SwiftUI

struct MeditationView: View {
    
    @State private var soundPlayer = SoundPlayer()
    @State private var exerciseOnePresented = false
    @State private var exerciseTwoPresented = false
    @State private var exerciseThreePresented = false
    @State private var exerciseFourPresented = false
    @State private var number = 0
    
    var body: some View {
        NavigationStack {
            GeometryReader { g in
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    ScrollView(showsIndicators: false) {
                        Spacer()
                            .frame(height: 25)
                        VStack {
                            Button(action: {
                                soundPlayer.getSound(name: "forestSoundEffect")
                                
                                if soundPlayer.audioPlayer != nil {
                                    exerciseOnePresented.toggle()
                                }
                            }) {
                                Image("croppedForest")
                                    .resizable()
                                    .frame(width: g.size.width * 0.9, height: 175)
                                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                    .aspectRatio(contentMode: .fit)
                                    .overlay {
                                        VStack {
                                            HStack {
                                                Text("02")
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.white)
                                                Text("Mins")
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.white)
                                                    .offset(x: -4, y: 4)
                                            }
                                            .background {
                                                RoundedRectangle(cornerRadius: 15.0)
                                                    .fill(.thinMaterial)
                                                    .padding(.horizontal, -5)
                                                    .padding(.vertical, -5)
                                                    .blur(radius: 35)
                                            }
                                        }
                                        .frame(maxHeight: .infinity, alignment: .top)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 15)
                                        .padding(.horizontal, 15)
                                        
                                        VStack {
                                            Text("Green Plains")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.white)
                                        }
                                        .frame(maxHeight: .infinity, alignment: .bottom)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 15)
                                        .padding(.horizontal, 15)
                                    }
                            }
                        }
                        
                        VStack {
                            Button(action: {
                                soundPlayer.getSound(name: "riverSoundEffect")
                                
                                if soundPlayer.audioPlayer != nil {
                                    exerciseTwoPresented.toggle()
                                }
                            }) {
                                Image("croppedPinkRiver")
                                    .resizable()
                                    .frame(width: g.size.width * 0.9, height: 175)
                                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                    .overlay {
                                        VStack {
                                            HStack {
                                                Text("01")
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.white)
                                                Text("Min")
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.white)
                                                    .offset(x: -4, y: 4)
                                            }
                                            .background {
                                                RoundedRectangle(cornerRadius: 15.0)
                                                    .fill(.thinMaterial)
                                                    .padding(.horizontal, -5)
                                                    .padding(.vertical, -5)
                                                    .blur(radius: 35)
                                            }
                                        }
                                        .frame(maxHeight: .infinity, alignment: .top)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 15)
                                        .padding(.horizontal, 15)
                                        
                                        VStack {
                                            Text("Pink Alps")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.white)
                                        }
                                        .frame(maxHeight: .infinity, alignment: .bottom)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 15)
                                        .padding(.horizontal, 15)
                                    }
                            }
                        }
                        
                        VStack {
                            Button(action: {
                                soundPlayer.getSound(name: "whiteNoiseSoundEffect")
                                
                                if soundPlayer.audioPlayer != nil {
                                    exerciseThreePresented.toggle()
                                }
                            }) {
                                Image("croppedAutumn")
                                    .resizable()
                                    .frame(width: g.size.width * 0.9, height: 175)
                                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                    .overlay {
                                        VStack {
                                            HStack {
                                                Text("03")
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.white)
                                                Text("Mins")
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.white)
                                                    .offset(x: -4, y: 4)
                                            }
                                            .background {
                                                RoundedRectangle(cornerRadius: 15.0)
                                                    .fill(.thinMaterial)
                                                    .padding(.horizontal, -5)
                                                    .padding(.vertical, -5)
                                                    .blur(radius: 35)
                                            }
                                        }
                                        .frame(maxHeight: .infinity, alignment: .top)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 15)
                                        .padding(.horizontal, 15)
                                        
                                        VStack {
                                            Text("Amber Plains")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.white)
                                        }
                                        .frame(maxHeight: .infinity, alignment: .bottom)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 15)
                                        .padding(.horizontal, 15)
                                    }
                            }
                        }
                        
                        VStack {
                            Button(action: {
                                soundPlayer.getSound(name: "oceanWavesSoundEffect")
                                
                                if soundPlayer.audioPlayer != nil {
                                    exerciseFourPresented.toggle()
                                }
                            }) {
                                Image("croppedBreezyOcean")
                                    .resizable()
                                    .frame(width: g.size.width * 0.9, height: 175)
                                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                    .overlay {
                                        VStack {
                                            HStack {
                                                Text("03")
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.white)
                                                Text("Mins")
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.white)
                                                    .offset(x: -4, y: 4)
                                            }
                                            .background {
                                                RoundedRectangle(cornerRadius: 15.0)
                                                    .fill(.thinMaterial)
                                                    .padding(.horizontal, -5)
                                                    .padding(.vertical, -5)
                                                    .blur(radius: 35)
                                            }
                                        }
                                        .frame(maxHeight: .infinity, alignment: .top)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 15)
                                        .padding(.horizontal, 15)
                                        
                                        VStack {
                                            Text("Serene Waves")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.white)
                                        }
                                        .frame(maxHeight: .infinity, alignment: .bottom)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 15)
                                        .padding(.horizontal, 15)
                                    }
                            }
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
            .toolbarBackground(Color("darkerGray").opacity(0.97), for: .navigationBar)
            .fullScreenCover(isPresented: $exerciseOnePresented) {
                MeditationOneView(soundPlayer: soundPlayer)
            }
            .fullScreenCover(isPresented: $exerciseTwoPresented) {
                MeditationTwoView(soundPlayer: soundPlayer)
            }
            .fullScreenCover(isPresented: $exerciseThreePresented) {
                MeditationThreeView(soundPlayer: soundPlayer)
            }
            .fullScreenCover(isPresented: $exerciseFourPresented) {
                MeditationFourView(soundPlayer: soundPlayer)
            }
        }
    }
}

#Preview {
    MeditationView()
}
