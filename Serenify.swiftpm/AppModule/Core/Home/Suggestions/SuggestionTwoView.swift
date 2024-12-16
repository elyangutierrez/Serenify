//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 12/14/24.
//

import SwiftUI

struct SuggestionTwoView: View {
    
    @State private var breathing = ""
    @State private var journaling = ""
    @State private var meditation = ""
    
    var suggestions = Suggestions()
    var width: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Breathing")
                .font(.headline)
            HStack {
                Text("-")
                
                VStack {
                    Text("\(breathing)")
//                        .background {
//                            RoundedRectangle(cornerRadius: 10.0)
//                                .fill(.ultraThinMaterial)
//                                .padding(.horizontal, -5)
//                                .padding(.vertical, -5)
//                        }
                }
            }
            .padding(.horizontal, 10)
            
            Text("Journaling")
                .font(.headline)
            HStack {
                Text("-")
                
                VStack {
                    Text("\(journaling)")
//                        .background {
//                            RoundedRectangle(cornerRadius: 10.0)
//                                .fill(.ultraThinMaterial)
//                                .padding(.horizontal, -5)
//                                .padding(.vertical, -5)
//                        }
                }
            }
            .padding(.horizontal, 10)
            
            Text("Meditation")
                .font(.headline)
            HStack {
                Text("-")
                
                VStack {
                    Text("\(meditation)")
//                        .background {
//                            RoundedRectangle(cornerRadius: 10.0)
//                                .fill(.ultraThinMaterial)
//                                .padding(.horizontal, -5)
//                                .padding(.vertical, -5)
//                        }
                }
            }
            .padding(.horizontal, 10)
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
        let afternoonSuggestions = suggestions.afternoonSuggestions
        
        let breathingArray = afternoonSuggestions["Breathing"]!
        let journalingArray = afternoonSuggestions["Journaling"]!
        let meditationArray = afternoonSuggestions["Meditation"]!
        
        let randomNum = Int.random(in: 0..<breathingArray.count)
        breathing = breathingArray[randomNum]
        let randomNum2 = Int.random(in: 0..<journalingArray.count)
        journaling = journalingArray[randomNum2]
        let randomNum3 = Int.random(in: 0..<meditationArray.count)
        meditation = meditationArray[randomNum3]

    }
}

#Preview {
    SuggestionTwoView(width: 400)
}
