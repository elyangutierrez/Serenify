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
    
    var soundPlayer: SoundPlayer
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
                                    Text("Explore the lush and lively")
                                    Text("Green Plains. 🌲")
                                    
                                    Spacer()
                                        .frame(height: 10)
                                }
                                .background {
                                    RoundedRectangle(cornerRadius: 15.0)
                                        .fill(.thinMaterial)
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
                        LinearGradient(colors: [Color.black, Color(hex: 0x0f1802)], startPoint: .bottom, endPoint: .top)
                            .frame(height: g.size.height * 0.3)
                            .overlay {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .stroke(Color("lighterGray"), lineWidth: 3)
                                        .fill(LinearGradient(colors: [Color("lightGray"), Color("darkGray")], startPoint: .top, endPoint: .bottom))
                                        .frame(maxWidth: g.size.width * 0.9, maxHeight: g.size.height * 0.3)
                                    
                                    VStack {
                                        HStack {
                                            VStack {
                                                Text("\(soundPlayer.formattedCurrentTime)")
                                                    .font(.headline)
//                                                    .fontWeight(.bold)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal, 25)
                                            
                                            VStack {
                                                Text("-\(soundPlayer.formattedTimeLeft)")
                                                    .font(.headline)
//                                                    .fontWeight(.bold)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding(.horizontal, 25)
                                        }
                                        .frame(maxWidth: g.size.width * 0.9, maxHeight: g.size.height * 0.3, alignment: .top)
                                    }
                                    .offset(y: 35)
                                    
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
//                                                Circle()
//                                                    .fill(Color("darkerGray").opacity(0.70))
//                                                    .frame(width: 50, height: 50)
//                                                    .overlay {
//                                                        Image(systemName: "gobackward.10")
//                                                            .resizable()
//                                                            .foregroundStyle(.white)
//                                                            .frame(width: 30, height: 30)
//                                                            .offset(y: -1)
//                                                    }
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
//                                                Circle()
//                                                    .fill(Color("darkerGray").opacity(0.70))
//                                                    .frame(width: 50, height: 50)
//                                                    .overlay {
//                                                        Image(systemName: "goforward.10")
//                                                            .resizable()
//                                                            .foregroundStyle(.white)
//                                                            .frame(width: 30, height: 30)
//                                                            .offset(y: -1)
//                                                    }
                                            }
                                            .disabled(soundPlayer.currentTime == 154)
                                        }
                                    }
                                    .frame(maxHeight: .infinity, alignment: .bottom)
                                    .padding(.vertical, 35)
                                }
                            }
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        soundPlayer.terminateProcesses()
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
