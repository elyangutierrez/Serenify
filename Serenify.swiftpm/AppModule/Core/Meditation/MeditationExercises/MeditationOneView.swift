//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/7/24.
//

import SwiftUI

struct MeditationOneView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var currentCount = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var soundPlayer: SoundPlayer
    
    var body: some View {
        NavigationStack {
            GeometryReader { g in
                ZStack {
                    VStack {
                        Image("Forest")
                            .resizable()
                            .ignoresSafeArea()
                            .frame(width: g.size.width, height: g.size.height * 0.7)
                            .scaledToFit()
                            .overlay {
                                VStack {
                                    Text("Green Plains")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                    
                                    Spacer()
                                        .frame(height: 10)
                                    Text("Listen to each sound in the forest")
                                    Text("and allow your mind to be quiet.")
                                    
                                    Spacer()
                                        .frame(height: g.size.height * 0.03)
                                }
                                .background {
                                    RoundedRectangle(cornerRadius: 15.0)
                                        .fill(.thinMaterial.opacity(0.5))
                                        .padding(.horizontal, -15)
                                        .padding(.vertical, -15)
                                        .blur(radius: 35)
                                }
                                .frame(maxHeight: .infinity, alignment: .bottom)
                                .padding(.vertical, 35)
                            }
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    ZStack {
                        Image("Forest")
                            .resizable()
                            .ignoresSafeArea()
                            .frame(width: g.size.width, height: g.size.height * 0.3)
                            .scaledToFit()
                            .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
                            .blur(radius: 45, opaque: true)
                            .mask {
                                LinearGradient(colors: [Color.clear, Color.black.opacity(0.8)], startPoint: .bottom, endPoint: .top)
                            }
                            .overlay {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .stroke(LinearGradient(colors: [Color("lighterGray"), Color.clear], startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                                        .fill(LinearGradient(colors: [Color("lightGray"), Color("darkGray")], startPoint: .top, endPoint: .bottom))
                                        .frame(maxWidth: g.size.width * 0.9, maxHeight: g.size.height * 0.3)
                                    
                                    VStack {
                                        HStack {
                                            VStack {
                                                Text("\(soundPlayer.formattedCurrentTime)")
                                                    .font(.headline)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal, 25)
                                            
                                            VStack {
                                                Text("-\(soundPlayer.formattedTimeLeft)")
                                                    .font(.headline)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding(.horizontal, 25)
                                        }
                                        .frame(maxWidth: g.size.width * 0.9, maxHeight: g.size.height * 0.3, alignment: .top)
                                    }
                                    .offset(y: g.size.height * 0.04)
                                    
                                    VStack {
                                        ProgressBarView(width: g.size.width * 0.8, current: soundPlayer.currentTime, total: soundPlayer.duration)
                                    }
                                    .offset(y: -20)
                                    
                                    VStack {
                                        HStack {
                                            Button(action: {
                                                // TODO: Go back 10 seconds
                                                soundPlayer.goBackwardTenSeconds()
                                            }) {
                                                Image(systemName: "gobackward.10")
                                                    .resizable()
                                                    .foregroundStyle(.white)
                                                    .frame(width: 30, height: 35)
                                                    .offset(y: -1)
                                            }
                                            
                                            Spacer()
                                                .frame(width: g.size.width * 0.07)
                                            
                                            Button(action: {
                                                soundPlayer.changeImage.toggle()
                                                soundPlayer.playerHandler()
                                            }) {
                                                Circle()
                                                    .fill(.black)
                                                    .frame(width: 70, height: 70)
                                                    .overlay {
                                                        Image(systemName: "pause.fill")
                                                            .resizable()
                                                            .frame(width: 20, height: 20)
                                                            .tint(.white)
                                                            .scaleEffect(soundPlayer.changeImage ? 1 : 0)
                                                            .opacity(soundPlayer.changeImage ? 1 : 0)
                                                            .animation(.interpolatingSpring(stiffness: 175, damping: 15), value: soundPlayer.changeImage)
                                                        
                                                        Image(systemName: "play.fill")
                                                            .resizable()
                                                            .frame(width: 20, height: 20)
                                                            .tint(.white)
                                                            .scaleEffect(soundPlayer.changeImage ? 0 : 1)
                                                            .opacity(soundPlayer.changeImage ? 0 : 1)
                                                            .animation(.interpolatingSpring(stiffness: 175, damping: 15), value: soundPlayer.changeImage)
                                                    }
                                                    .onReceive(timer) { i in
                                                        if soundPlayer.isPlaying && currentCount <= 154 {
                                                            currentCount += 1
//
                                                            soundPlayer.updateVariables()
                                                            
                                                            if currentCount == 154 || soundPlayer.currentTime == 0 {
                                                                soundPlayer.isPlaying = false
                                                                soundPlayer.changeImage = false
                                                            }
                                                        }
                                                    }
                                                    .shadow(radius: 5, y: 5)
                                                    .shadow(radius: 5, y: 5)
                                            }
                                            
                                            Spacer()
                                                .frame(width: g.size.width * 0.07)
                                            
                                            Button(action: {
                                                // TODO: Go forward 10 seconds
                                                soundPlayer.goForwardTenSeconds()
                                            }) {
                                                Image(systemName: "goforward.10")
                                                    .resizable()
                                                    .foregroundStyle(.white)
                                                    .frame(width: 30, height: 35)
                                                    .offset(y: -1)
                                            }
                                            .disabled(soundPlayer.currentTime == 154)
                                        }
                                    }
                                    .frame(maxHeight: .infinity, alignment: .bottom)
                                    .padding(.vertical, g.size.height * 0.04)
                                }
                                .offset(y: -20)
                            }
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        soundPlayer.terminatePlayer()
                        dismiss()
                    }) {
                        Circle()
                            .fill(.ultraThinMaterial)
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
