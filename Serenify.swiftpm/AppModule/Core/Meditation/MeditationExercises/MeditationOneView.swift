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
            GeometryReader { g in
                ZStack {
                    VStack {
                        Image("Forest")
                            .resizable()
                            .ignoresSafeArea()
                            .frame(width: g.size.width, height: g.size.height * 0.6)
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
                            .frame(height: g.size.height * 0.4)
                            .overlay {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 45.0)
                                        .stroke(Color("lighterGray"), lineWidth: 3)
                                        .fill(LinearGradient(colors: [Color("lightGray"), Color("darkGray")], startPoint: .top, endPoint: .bottom))
                                        .frame(maxWidth: g.size.width * 0.9, maxHeight: g.size.height * 0.3)
                                    
                                    VStack {
                                        HStack {
                                            VStack {
                                                Text("Current")
                                                    .fontWeight(.bold)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal, 25)
                                            
                                            VStack {
                                                Text("Remaining")
                                                    .fontWeight(.bold)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding(.horizontal, 25)
                                        }
                                        .frame(maxWidth: g.size.width * 0.9, maxHeight: g.size.height * 0.3, alignment: .top)
                                    }
                                    .offset(y: 35)
                                    
                                    VStack {
                                        Button(action: {
                                            soundPlayer.playerHandler()
                                        }) {
                                            Circle()
                                                .frame(width: 70, height: 70)
                                        }
                                    }
                                    .frame(maxHeight: .infinity, alignment: .bottom)
                                    .padding(.vertical, 65)
                                }
                            }
                        
//                        VStack {
//                            HStack {
//                                VStack {
//                                    Text("Current")
//                                }
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .padding(.horizontal, 15)
//                                
//                                VStack {
//                                    Text("Remaining")
//                                }
//                                .frame(maxWidth: .infinity, alignment: .trailing)
//                                .padding(.horizontal, 15)
//                            }
//                            .frame(maxWidth: g.size.width * 0.9)
//                            
//                            VStack {
//                                Button(action: {
//                                    
//                                }) {
//                                    Circle()
//                                        .frame(width: 60, height: 60)
//                                }
//                            }
//                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
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
