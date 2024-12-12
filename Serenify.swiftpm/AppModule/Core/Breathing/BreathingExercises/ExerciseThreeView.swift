//
//  SwiftUIView 2.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/30/24.
//

import SwiftUI

struct ExerciseThreeView: View {
    
    @Binding var isPresented: Bool
    
    @AppStorage("isFirstTime3") var isFirstTime = true
    
    @State private var elapsedTime = 0
    @State private var currentNumber = 0
    @State private var currentPhase = 1
    @State private var phaseOneNumber = 1
    @State private var phaseTwoNumber = 1
    @State private var phaseThreeNumber = 1
    @State private var isPlaying = false
    @State private var selectedBreathingOption = "Start"
    @State private var normalizedValue = 0.0
    @State private var currentRound = 0
    @State private var showInfoSheet = false
    @State private var preventInitialShake = false
    
    let breathingOptions = ["Start", "Inhale", "Hold", "Exhale", "End"]
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // Creates a timer that updates user interface per second
    
    var hapticsManager = HapticsManager()
        
    var body: some View {
        NavigationStack {
            GeometryReader { g in
                ZStack {
                    LinearGradient(colors: [Color("pastelGold"), Color("darkerPastelGold")], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    VStack {
                        
                        Text("\(currentRound)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .contentTransition(.numericText(countsDown: false))
                            .transaction { t in
                                if preventInitialShake {
                                    t.animation = .default
                                }
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
                                                    t.animation = .smooth(duration: 0.2)
                                                }
                                                .onReceive(timer) { i in
                                                    if isPlaying && elapsedTime <= 28 {
                                                        elapsedTime += 1
                                                        normalizedValue = Double(elapsedTime) / 27.0
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
                                                    if preventInitialShake {
                                                        t.animation = .default
                                                    }
                                                }
                                        }
                                    }
                            }
                        
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            Button(action: {
                                isPlaying.toggle()
                            }) {
                                Circle()
                                    .fill(.black)
                                    .frame(width: g.size.width * 0.25)
                                    .overlay {
                                        Image(systemName: "pause.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .tint(.white)
                                            .scaleEffect(isPlaying ? 1 : 0)
                                            .opacity(isPlaying ? 1 : 0)
                                            .animation(.interpolatingSpring(stiffness: 175, damping: 15), value: isPlaying)
                                        
                                        Image(systemName: "play.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .tint(.white)
                                            .scaleEffect(isPlaying ? 0 : 1)
                                            .opacity(isPlaying ? 0 : 1)
                                            .animation(.interpolatingSpring(stiffness: 175, damping: 15), value: isPlaying)
                                    }
                                    .shadow(radius: 5, y: 5)
                                    .shadow(radius: 5, y: 5)
                            }
                        } else if UIDevice.current.userInterfaceIdiom == .pad {
                            Button(action: {
                                isPlaying.toggle()
                            }) {
                                Circle()
                                    .fill(.black)
                                    .frame(width: g.size.width * 0.25)
                                    .overlay {
                                        Image(systemName: "pause.fill")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .tint(.white)
                                            .scaleEffect(isPlaying ? 1 : 0)
                                            .opacity(isPlaying ? 1 : 0)
                                            .animation(.interpolatingSpring(stiffness: 175, damping: 15), value: isPlaying)
                                        
                                        Image(systemName: "play.fill")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .tint(.white)
                                            .scaleEffect(isPlaying ? 0 : 1)
                                            .opacity(isPlaying ? 0 : 1)
                                            .animation(.interpolatingSpring(stiffness: 175, damping: 15), value: isPlaying)
                                    }
                                    .shadow(radius: 5, y: 5)
                                    .shadow(radius: 5, y: 5)
                            }
                        }
                        
                        Spacer()
                            .frame(height: 20)
                    }
                    .blur(radius: isFirstTime || showInfoSheet ? 5 : 0)
                }
                .animation(.easeInOut(duration: 0.1), value: showInfoSheet || isFirstTime)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("3-3-3 Breathing")
                        .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Circle()
                            .fill(Color("darkerPastelGold"))
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image(systemName: "xmark")
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                            }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button(action: {
                            reset()
                        }) {
                            Label("Reset", systemImage: "arrow.clockwise")
                        }
                        
                        Button(action: {
                            showInfoSheet.toggle()
                        }) {
                            Label("Info", systemImage: "info")
                        }
                    } label: {
                        Circle()
                            .fill(Color("darkerPastelGold"))
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image(systemName: "ellipsis")
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                            }
                    }
                }
            }
            .sheet(isPresented: $showInfoSheet) {
                ScrollView {
                    VStack(alignment: .leading) {
                        VStack {
                            Text("Exercise Info")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        Spacer()
                            .frame(height: 20)
                        
                        VStack(alignment: .leading) {
                            Text("Inhale through the nose for 3 seconds. Hold for breath for 3 seconds. Exhale through the mouth for 3 seconds. Repeat for 3 times.")
                        }
                        .offset(y: -5)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
                .onAppear {
                    isPlaying = false
                }
                .presentationDragIndicator(.visible)
                .presentationDetents([.height((UIScreen.current?.bounds.size.height ?? 200) * 0.25)])
                .presentationCornerRadius(25.0)
            }
            .sheet(isPresented: $isFirstTime, onDismiss: {
                isFirstTime = false
            }) {
                ScrollView {
                    VStack(alignment: .leading) {
                        VStack {
                            Text("Exercise Info")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        VStack(alignment: .leading) {
                            Text("Inhale through the nose for 3 seconds. Hold for breath for 3 seconds. Exhale through the mouth for 3 seconds. Repeat for 3 times.")
                        }
                        .offset(y: -5)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
                .presentationDragIndicator(.visible)
                .presentationDetents([.height((UIScreen.current?.bounds.size.height ?? 200) * 0.25)])
                .presentationCornerRadius(25.0)
            }
            .onAppear {
                DispatchQueue.main.async {
                    preventInitialShake = true
                }
            }
        }
    }
    
    func phaselogic(time: Int) {
        
        // Play a haptic when going to the next round/end.
        
        if time.isMultiple(of: 9) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                hapticsManager.roundChange()
                currentRound += 1
            }
        }

        // Logic for changing phases, numbers, and text
        
        if time < 28 {
            switch currentPhase {
            case 1:
                currentNumber = phaseOneNumber
                phaseOneNumber += 1
                selectedBreathingOption = breathingOptions[1]
                if currentNumber == 3 {
                    currentPhase = 2
                    phaseOneNumber = 1
                }
            case 2:
                currentNumber = phaseTwoNumber
                phaseTwoNumber += 1
                selectedBreathingOption = breathingOptions[2]
                if currentNumber == 3 {
                    currentPhase = 3
                    phaseTwoNumber = 1
                }
            case 3:
                currentNumber = phaseThreeNumber
                phaseThreeNumber += 1
                selectedBreathingOption = breathingOptions[3]
                if currentNumber == 3 {
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
    ExerciseThreeView(isPresented: .constant(true))
}
