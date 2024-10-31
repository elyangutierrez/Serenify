//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/29/24.
//

import SwiftUI

struct TechniquesView: View {
    
    var body: some View {
        NavigationStack {
            GeometryReader { g in
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    ScrollView {
                        Spacer()
                            .frame(height: 20)
                        
                        VStack(alignment: .leading) {
                            Text("Deep Breathing")
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
                        
                        VStack {
                            Text("Grounding")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        
                        VStack {
                            ExerciseFiveCapsule(geometryWidth: g.size.width * 0.90)
                        }
                        
                        Spacer()
                            .frame(height: 20)
                        
                        VStack {
                            ExerciseSixCapsule(geometryWidth: g.size.width * 0.90)
                        }
                        
                        Spacer()
                            .frame(height: 20)
                        
                        VStack {
                            ExerciseSevenCapsule(geometryWidth: g.size.width * 0.90)
                        }
                        
                        Spacer()
                            .frame(height: 20)
                        
                        VStack {
                            ExerciseEightCapsule(geometryWidth: g.size.width * 0.90)
                        }
                        
                        Spacer()
                            .frame(height: 40)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Techniques")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
            }
            .toolbarBackground(Color.black.opacity(0.85), for: .navigationBar)
        }
    }
}

#Preview {
    TechniquesView()
}
