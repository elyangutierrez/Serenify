//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/29/24.
//

import SwiftUI

struct MeditationView: View {
    
    @State private var currentInfo: CurrentInfo?
    @State private var soundPlayer = SoundPlayer()
    @State private var exercisePresented = false
    @State private var number = 0
    
    var meditationInfo = MeditationInfo()
    
    var body: some View {
        NavigationStack {
            GeometryReader { g in
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    
                    ScrollView(showsIndicators: false) {
                        Spacer()
                            .frame(height: 25)
                        
                        ForEach(meditationInfo.meditations, id: \.self) { meditation in
                            VStack {
                                Button(action: {
                                    soundPlayer.getSound(name: meditation["sound"]!)
                                    if soundPlayer.audioPlayer != nil {
                                        currentInfo = CurrentInfo(info: meditation)
                                        exercisePresented.toggle()
                                    }
                                }) {
                                    Image(meditation["croppedImage"]!)
                                        .resizable()
                                        .frame(width: g.size.width * 0.9, height: 175)
                                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                        .aspectRatio(contentMode: .fit)
                                        .overlay {
                                            VStack {
                                                HStack {
                                                    Text(meditation["time"]!)
                                                        .font(.title)
                                                        .fontWeight(.bold)
                                                        .foregroundStyle(.white)
                                                    Text(meditation["timePeriod"]!)
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
                                                Text(meditation["title"]!)
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
            .fullScreenCover(item: $currentInfo) { current in
                MeditationTemplateView(soundPlayer: soundPlayer, info: current.info)
            }
        }
    }
}

#Preview {
    MeditationView()
}
