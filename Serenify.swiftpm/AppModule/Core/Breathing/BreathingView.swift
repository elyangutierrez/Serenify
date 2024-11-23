//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/29/24.
//

import SwiftUI

struct BreathingView: View {
    
    var body: some View {
        NavigationStack {
            GeometryReader { g in
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    ScrollView(showsIndicators: false) {
                        Spacer()
                            .frame(height: 20)
                        
                        VStack(alignment: .leading) {
                            Text("Exercises")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        VStack {
                            // Grid here...
                            HStack {
                                VStack {
                                    ExerciseOneCapsule(geometryWidth: g.size.width)
                                }
                                
                                Spacer()
                                    .frame(width: g.size.width * 0.06)
                                
                                VStack {
                                    ExerciseTwoCapsule(geometryWidth: g.size.width)
                                }
                            }
                            
                            Spacer()
                                .frame(height: 20)
                            
                            HStack  {
                                VStack {
                                    ExerciseThreeCapsule(geometryWidth: g.size.width)
                                }
                                
                                Spacer()
                                    .frame(width: g.size.width * 0.06)
                                
                                VStack {
                                    ExerciseFourCapsule(geometryWidth: g.size.width)
                                }
                            }
                        }
                        
                        
                       Spacer()
                           .frame(height: 20)
                        
                        VStack(alignment: .leading) {
                            Text("Longer Exercises")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                         
                        Spacer()
                            .frame(height: 20)
                        
                        VStack {
                            ExerciseFiveCapsule(geometryWidth: g.size.width * 0.9)
                        }
                        
                        Spacer()
                            .frame(height: 20)
                        
                        VStack {
                            ExerciseSixCapsule(geometryWidth: g.size.width * 0.9)
                        }
                        
                        Spacer()
                            .frame(height: 20)
                        
                        VStack {
                            ExerciseSevenCapsule(geometryWidth: g.size.width * 0.9)
                        }
                        
                        Spacer()
                            .frame(height: 20)
                        
                        VStack {
                            ExerciseEightCapsule(geometryWidth: g.size.width * 0.9)
                        }
                        
                        Spacer()
                            .frame(height: 40)
                    }
                }
            }
            .preferredColorScheme(.dark)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Breathing")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
            }
            .toolbarBackground(Color("darkerGray").opacity(0.97), for: .navigationBar)
        }
    }
}

#Preview {
    BreathingView()
}
