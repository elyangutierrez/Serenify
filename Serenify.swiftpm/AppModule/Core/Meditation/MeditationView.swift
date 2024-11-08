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
                                exerciseOnePresented.toggle()
                            }) {
//                                RoundedRectangle(cornerRadius: 15.0)
//                                    .fill(Color("darkerPastelGreen"))
//                                    .frame(width: g.size.width * 0.9, height: 175)
//                                    .overlay {
//                                        VStack {
//                                            HStack {
//                                                Text("03")
//                                                    .font(.title)
//                                                    .fontWeight(.bold)
//                                                    .foregroundStyle(.black)
//                                                Text("Mins")
//                                                    .fontWeight(.bold)
//                                                    .foregroundStyle(Color("darkGray"))
//                                                    .offset(x: -4, y: 4)
//                                            }
//                                        }
//                                        .frame(maxHeight: .infinity, alignment: .top)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                        .padding(.vertical, 15)
//                                        .padding(.horizontal, 15)
//                                        
//                                        VStack {
//                                            Text("Green Plains")
//                                                .font(.title2)
//                                                .fontWeight(.bold)
//                                                .foregroundStyle(.black)
//                                        }
//                                        .frame(maxHeight: .infinity, alignment: .bottom)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                        .padding(.vertical, 15)
//                                        .padding(.horizontal, 15)
//                                    }
                                
                                Image("croppedForest")
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
                                exerciseTwoPresented.toggle()
                            }) {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .fill(Color("darkerPastelPink"))
                                    .frame(width: g.size.width * 0.9, height: 175)
                                    .overlay {
                                        VStack {
                                            HStack {
                                                Text("03")
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.black)
                                                Text("Mins")
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(Color("darkGray"))
                                                    .offset(x: -4, y: 4)
                                            }
                                            
                                        }
                                        .frame(maxHeight: .infinity, alignment: .top)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 15)
                                        .padding(.horizontal, 15)
                                        
                                        VStack {
                                            Text("Green Everglades")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.black)
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
                                exerciseThreePresented.toggle()
                            }) {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .fill(Color("darkerPastelGold"))
                                    .frame(width: g.size.width * 0.9, height: 175)
                                    .overlay {
                                        VStack {
                                            HStack {
                                                Text("03")
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.black)
                                                Text("Mins")
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(Color("darkGray"))
                                                    .offset(x: -4, y: 4)
                                            }
                                           
                                        }
                                        .frame(maxHeight: .infinity, alignment: .top)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 15)
                                        .padding(.horizontal, 15)
                                        
                                        VStack {
                                            Text("Green Everglades")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.black)
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
                                exerciseFourPresented.toggle()
                            }) {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .fill(Color("darkerPastelBlue"))
                                    .frame(width: g.size.width * 0.9, height: 175)
                                    .overlay {
                                        VStack {
                                            HStack {
                                                Text("03")
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.black)
                                                Text("Mins")
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(Color("darkGray"))
                                                    .offset(x: -4, y: 4)
                                            }
                                            
                                        }
                                        .frame(maxHeight: .infinity, alignment: .top)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 15)
                                        .padding(.horizontal, 15)
                                        
                                        VStack {
                                            Text("Green Everglades")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.black)
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
                MeditationTwoView()
            }
            .fullScreenCover(isPresented: $exerciseThreePresented) {
                MeditationThreeView()
            }
            .fullScreenCover(isPresented: $exerciseFourPresented) {
                MeditationFourView()
            }
        }
    }
}

#Preview {
    MeditationView()
}
