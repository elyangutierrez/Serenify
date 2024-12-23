//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 12/14/24.
//

import SwiftUI

struct SuggestionThreeView: View {
    
    @State private var breathing = ""
    @State private var journaling = ""
    @State private var meditation = ""
    
    var suggestions = Suggestions()
    var width: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                Text("Breathing")
                    .font(.headline)
                
                Spacer()
                    .frame(height: 5)
                
                HStack {
                    VStack {
                        Text("•")
                    }
                    
                    VStack {
                        Text("\(breathing)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(.ultraThinMaterial)
            }
            
            VStack(alignment: .leading) {
                Text("Journaling")
                    .font(.headline)
                
                Spacer()
                    .frame(height: 5)
                
                HStack {
                    Text("•")
                    
                    Text("\(journaling)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(.ultraThinMaterial)
            }
            
            VStack(alignment: .leading) {
                Text("Meditation")
                    .font(.headline)
                
                Spacer()
                    .frame(height: 5)
                
                HStack {
                    Text("•")
                    
                    Text("\(meditation)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(.ultraThinMaterial)
            }
        }
        .frame(maxWidth: width, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.regularMaterial)
                .padding(.horizontal, -10)
                .padding(.vertical, -10)
        }
        .padding()
        .onAppear {
            getSuggestions()
        }
    }
    
    func getSuggestions() {
        let eveningSuggestions = suggestions.afternoonSuggestions
        
        let breathingArray = eveningSuggestions["Breathing"]!
        let journalingArray = eveningSuggestions["Journaling"]!
        let meditationArray = eveningSuggestions["Meditation"]!
        
        let randomNum = Int.random(in: 0..<breathingArray.count)
        breathing = breathingArray[randomNum]
        let randomNum2 = Int.random(in: 0..<journalingArray.count)
        journaling = journalingArray[randomNum2]
        let randomNum3 = Int.random(in: 0..<meditationArray.count)
        meditation = meditationArray[randomNum3]

    }
}

#Preview {
    SuggestionThreeView(width: 400)
}
