//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/19/24.
//

import SwiftUI

struct MoodSelectionView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var scale = 0.0
    @State private var currentMood = 20.0
    
    var body: some View {
        NavigationStack {
            GeometryReader { g in
                VStack {
                    HStack {
                        Text("😃")
                            .font(.title)
                            .scaleEffect(currentMood == 20.0 ? 1.3 : 1.0)
                            .onTapGesture {
                                currentMood = 20
                            }
                        Spacer()
                            .frame(width: 30)
                        
                        Text("🙂")
                            .font(.title)
                            .scaleEffect(currentMood == 40.0 ? 1.3 : 1.0)
                        
                        Spacer()
                            .frame(width: 30)
                        
                        Text("😐")
                            .font(.title)
                            .scaleEffect(currentMood == 60.0 ? 1.3 : 1.0)
                        
                        Spacer()
                            .frame(width: 30)
                        
                        Text("☹️")
                            .font(.title)
                            .scaleEffect(currentMood == 80.0 ? 1.3 : 1.0)
                        
                        Spacer()
                            .frame(width: 30)
                        
                        Text("😭")
                            .font(.title)
                            .scaleEffect(currentMood == 100.0 ? 1.3 : 1.0)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(maxHeight: .infinity, alignment: .center)
//
                VStack {
                    Button(action: {
                        
                    }) {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(.regularMaterial)
                            .frame(maxWidth: g.size.width * 0.95, maxHeight: 50)
                            .overlay {
                                VStack {
                                    Text("Confirm Mood")
                                        .foregroundStyle(.white).bold()
                                }
                            }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 15)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Check In")
                }
                
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Circle()
                            .fill(.thinMaterial)
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 15, height: 15)
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
    MoodSelectionView()
}
