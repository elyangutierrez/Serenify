//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/30/24.
//

import SwiftUI

struct ExerciseTwoView: View {
    
    @Binding var isPresented: Bool
    
    @State private var elapsedTime = 0
    @State private var currentNumber = 0
    @State private var currentPhase = 1
    @State private var phaseOneNumber = 1
    @State private var phaseTwoNumber = 1
    @State private var phaseThreeNumber = 1
    @State private var phaseFourNumber = 1
    @State private var isPlaying = false
    @State private var selectedBreathingOption = "Start"
    @State private var normalizedValue = 0.0
    @State private var currentRound = 0
    @ObservedObject private var hapticsManager = HapticsManager()
    var backgroundColor: String
    
    let breathingOptions = ["Start", "Inhale", "Hold", "Exhale", "End"]
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // Creates a timer that updates user interface per second
        
    var body: some View {
        NavigationStack {
            GeometryReader { g in
                ZStack {
                    LinearGradient(colors: [Color("pastelBlue"), Color("darkerPastelBlue")], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    VStack {
                        
                        Text("\(currentRound)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .contentTransition(.numericText(countsDown: false))
                            .transaction { t in
                                t.animation = .default
                            }
                            .offset(y: 50)
                        
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
                                                    t.animation = .default
                                                }
                                                .onReceive(timer) { i in
                                                    if isPlaying && elapsedTime <= 49 {
                                                        elapsedTime += 1
                                                        normalizedValue = Double(elapsedTime) / 48.0
                                                        phaselogic(time: elapsedTime)
                                                        print("Time: \(elapsedTime) secs")
                                                    }
                                                }

                                            Spacer()
                                                .frame(height: 20)
                                            
                                            Text("0\(currentNumber)")
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
                    Text("Box Breathing")
                        .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Circle()
                            .fill(Color("darkerPastelBlue"))
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
                            .fill(Color("darkerPastelBlue"))
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
        
        // TODO: Match with 4-4-4-4
        if time == 17 {
            hapticsManager.roundChange()
            currentRound = 1
        } else if time == 33 {
            hapticsManager.roundChange()
            currentRound = 2
        } else if time == 49 {
            hapticsManager.roundChange()
            currentRound = 3
        }

        // Logic for changing phases, numbers, and text
        
        if time < 49 {
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
                if currentNumber == 4 {
                    currentPhase = 3
                    phaseTwoNumber = 1
                }
            case 3:
                currentNumber = phaseThreeNumber
                phaseThreeNumber += 1
                selectedBreathingOption = breathingOptions[3]
                if currentNumber == 4 {
                    currentPhase = 4
                    phaseThreeNumber = 1
                }
            case 4:
                currentNumber = phaseThreeNumber
                phaseThreeNumber += 1
                selectedBreathingOption = breathingOptions[2]
                if currentNumber == 4 {
                    currentPhase = 1
                    phaseThreeNumber = 1
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
        
        selectedBreathingOption = breathingOptions[4]
        currentNumber = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            phaseOneNumber = 1
            phaseTwoNumber = 1
            phaseThreeNumber = 1
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
        phaseThreeNumber = 1
        currentPhase = 1
        elapsedTime = 0
        normalizedValue = 0
        currentRound = 0
    }
}

#Preview {
    ExerciseTwoView(isPresented: .constant(true), backgroundColor: "pastelBlue")
}
