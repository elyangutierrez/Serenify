//
//  SwiftUIView 3.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/30/24.
//

import SwiftUI

struct ExerciseFourView: View {
    
    @Binding var isPresented: Bool
    
    @State private var elapsedTime = 0
    @State private var currentNumber = 0
    @State private var currentPhase = 1
    @State private var phaseOneNumber = 1
    @State private var phaseTwoNumber = 1
    @State private var isPlaying = false
    @State private var selectedBreathingOption = "Start"
    @State private var normalizedValue = 0.0
    @State private var currentRound = 0
    @State private var currentCount = 6
    @ObservedObject private var hapticsManager = HapticsManager()
    var backgroundColor: String
    
    let breathingOptions = ["Start", "Inhale", "Exhale", "End"]
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // Creates a timer that updates user interface per second
        
    var body: some View {
        NavigationStack {
            GeometryReader { g in
                ZStack {
                    LinearGradient(colors: [Color("pastelPink"), Color("darkerPastelPink")], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    VStack {
                        
//                        Text("\(currentRound)")
//                            .font(.largeTitle)
//                            .fontWeight(.bold)
//                            .contentTransition(.numericText(countsDown: false))
//                            .transaction { t in
//                                t.animation = .default
//                            }
//                            .offset(y: 50)
                        
                        ProgressCircleView(progress: normalizedValue)
                            .frame(width: g.size.width * 0.70, height: g.size.height * 0.70)
                            .overlay {
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: g.size.width * 0.55, height: g.size.height * 0.55)
                                    .overlay {
                                        VStack {
                                            Text(selectedBreathingOption)
                                                .font(.largeTitle)
                                                .fontWeight(.bold)
                                                .italic()
                                                .foregroundStyle(.white)
                                                .contentTransition(.interpolate)
                                                .transaction { t in
                                                    t.animation = .smooth(duration: 0.2)
                                                }
                                                .onReceive(timer) { i in
                                                    if isPlaying && elapsedTime <= 61 {
                                                        elapsedTime += 1
                                                        normalizedValue = Double(elapsedTime) / 60.0
                                                        phaselogic(time: elapsedTime)
                                                        print("Time: \(elapsedTime) secs")
                                                    }
                                                }

                                            Spacer()
                                                .frame(height: 20)
                                            
                                            Text("\(currentNumber)")
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.white)
                                                .contentTransition(.numericText(countsDown: false))
                                                .transaction { t in
                                                    t.animation = .default
                                                }
                                        }
                                    }
                            }
                        
                        VStack {
                            VStack {
                                Button(action: {
                                    isPlaying.toggle()
                                }) {
                                    Circle()
                                        .fill(.black)
                                        .frame(width: g.size.width * 0.27)
                                        .overlay {
                                            Image(systemName: isPlaying == true ? "pause.fill" : "play.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .tint(.white)
                                        }
                                        .shadow(radius: 5, y: 5)
                                        .shadow(radius: 5, y: 5)
                                        .contentTransition(.interpolate)
                                        .transaction { t in
                                            t.animation = .smooth(duration: 0.1)
                                        }
                                }
                            }
                            .offset(y: 15)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Extended Breathing")
                        .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Circle()
                            .fill(Color("darkerPastelPink"))
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image(systemName: "xmark")
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                            }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        reset()
                    }) {
                        Circle()
                            .fill(Color("darkerPastelPink"))
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image(systemName: "arrow.clockwise")
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                    .offset(y: -1)
                            }
                    }
                }
            }
        }
    }
    
    func phaselogic(time: Int) {
        
        // Play a haptic when going to the next round/end.
        
        if time == 61 {
            hapticsManager.roundChange()
        }
            

        // Logic for changing phases, numbers, and text
        
        if time < 61 {
            switch currentPhase {
            case 1:
                currentNumber = phaseOneNumber
                phaseOneNumber += 1
                selectedBreathingOption = breathingOptions[1]
                
                if currentNumber == 4 {
                    currentPhase = 2
                    phaseOneNumber = 1
                }
            case 2:
                currentNumber = phaseTwoNumber
                phaseTwoNumber += 1
                selectedBreathingOption = breathingOptions[2]
                
                if currentNumber == currentCount {
                    currentPhase = 1
                    phaseTwoNumber = 1
                    currentCount += 1
                }
            default:
                print("Something weird happened...")
            }
        } else {
            resetWhenCompleted()
        }
    }
    
    func resetWhenCompleted() {
        // Resets back to original state
        
        isPlaying = false
        
        selectedBreathingOption = breathingOptions[3]
        currentNumber = 0
        currentCount = 6
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            phaseOneNumber = 1
            phaseTwoNumber = 1
            currentPhase = 1
            selectedBreathingOption = breathingOptions[0]
            elapsedTime = 0
            normalizedValue = 0
            currentRound = 0
        }
    }
    
    func reset() {
        isPlaying = false
        currentNumber = 0
        selectedBreathingOption = breathingOptions[0]
        phaseOneNumber = 1
        phaseTwoNumber = 1
        currentPhase = 1
        elapsedTime = 0
        normalizedValue = 0
        currentRound = 0
    }
}

#Preview {
    ExerciseFourView(isPresented: .constant(true), backgroundColor: "pastelPink")
}
