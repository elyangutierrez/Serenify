//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/6/24.
//

import SwiftUI

struct JournalEntryTypeView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var isPresented: Bool
    
    @State private var promptOneColor = ""
    @State private var promptOneColorTwo = ""
    @State private var promptTwoColor = ""
    @State private var promptTwoColorTwo = ""
    @State private var promptThreeColor = ""
    @State private var promptThreeColorTwo = ""
    @State private var selectedPromptCategory = "Mindfulness"
    @State private var prompts = JournalPrompts()
    @State private var promptOneText = ""
    @State private var promptTwoText = ""
    @State private var promptThreeText = ""
    @State private var showPromptEntryView = false
    @State private var selectedPrompt = ""
    @State private var showRegularPrompt = false
    
    let colors = ["pastelGreen", "pastelBlue", "pastelGold", "pastelPink"]
    let darkerColors = ["darkerPastelGreen", "darkerPastelBlue", "darkerPastelGold", "darkerPastelPink"]
    let promptCategories = ["Mindfulness", "Simple", "Self-Soothing", "Gratitude"]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                GeometryReader { g in
                    ScrollView {
                        
                        Spacer()
                            .frame(height: 25)
                        
                        VStack {
                            VStack {
                                Button(action: {
                                    showRegularPrompt.toggle()
                                }) {
                                    RoundedRectangle(cornerRadius: 15.0)
                                        .fill(Color("darkGray"))
                                        .frame(width: g.size.width * 0.95, height: 60)
                                        .overlay {
                                            VStack {
                                                HStack {
                                                    Image(systemName: "square.and.pencil")
                                                        .resizable()
                                                        .frame(width: 25, height: 25)
                                                        .foregroundStyle(.white)
                                                        .fontWeight(.bold)
                                                    Text("Create Entry Without Prompt")
                                                        .foregroundStyle(.white)
                                                        .fontWeight(.bold)
                                                }
                                            }
                                        }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.vertical, 15)
                        
                        VStack {
                            
                            Picker("", selection: $selectedPromptCategory) {
                                ForEach(promptCategories, id: \.self) {
                                    Text($0)
                                        .font(.caption)
                                }
                            }
                            .frame(maxWidth: g.size.width * 0.95)
                            .pickerStyle(.segmented)
                            
                            Spacer()
                                .frame(height: 25)
                            
                            VStack {
                                Button(action: {
                                    //                                print("Tapped button 1!")
                                    //                                print("Prompt One Text: \(promptOneText)")
                                    selectedPrompt = promptOneText
                                    //                                print("Selected prompt: \(selectedPrompt)")
                                    showPromptEntryView.toggle()
                                }) {
                                    RoundedRectangle(cornerRadius: 15.0)
                                        .fill(LinearGradient(colors: [Color(promptOneColor), Color(promptOneColorTwo)], startPoint: .top, endPoint: .bottom))
                                        .frame(width: g.size.width * 0.95, height: 150)
                                        .onAppear {
                                            
                                            setPrompts()
                                        }
                                        .overlay {
                                            
                                            VStack {
                                                Text("💭")
                                                    .font(.title)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .frame(maxHeight: .infinity, alignment: .top)
                                            .padding(.horizontal, 15)
                                            .padding(.vertical, 15)
                                            
                                            VStack(alignment: .leading) {
                                                Text(promptOneText)
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.black)
                                                    .multilineTextAlignment(.leading)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .frame(maxHeight: .infinity, alignment: .bottom)
                                            .padding(.horizontal, 15)
                                            .padding(.vertical, 15)
                                        }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                            VStack {
                                Button(action: {
                                    //                                print("Tapped button 2!")
                                    selectedPrompt = promptTwoText
                                    //                                print("Selected prompt: \(selectedPrompt)")
                                    showPromptEntryView.toggle()
                                }) {
                                    RoundedRectangle(cornerRadius: 15.0)
                                        .fill(LinearGradient(colors: [Color(promptTwoColor), Color(promptTwoColorTwo)], startPoint: .top, endPoint: .bottom))
                                        .frame(width: g.size.width * 0.95, height: 150)
                                        .onAppear {
                                            
                                            setPrompts()
                                        }
                                        .overlay {
                                            
                                            VStack {
                                                Text("💭")
                                                    .font(.title)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .frame(maxHeight: .infinity, alignment: .top)
                                            .padding(.horizontal, 15)
                                            .padding(.vertical, 15)
                                            
                                            VStack(alignment: .leading) {
                                                Text(promptTwoText)
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.black)
                                                    .multilineTextAlignment(.leading)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .frame(maxHeight: .infinity, alignment: .bottom)
                                            .padding(.horizontal, 15)
                                            .padding(.vertical, 15)
                                        }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                            
                            VStack {
                                Button(action: {
                                    //                                print("Tapped button 3!")
                                    selectedPrompt = promptThreeText
                                    //                                print("Selected prompt: \(selectedPrompt)")
                                    showPromptEntryView.toggle()
                                }) {
                                    RoundedRectangle(cornerRadius: 15.0)
                                        .fill(LinearGradient(colors: [Color(promptThreeColor), Color(promptThreeColorTwo)], startPoint: .top, endPoint: .bottom))
                                        .frame(width: g.size.width * 0.95, height: 150)
                                        .onAppear {
                                            
                                            setPrompts()
                                        }
                                        .overlay {
                                            
                                            VStack {
                                                Text("💭")
                                                    .font(.title)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .frame(maxHeight: .infinity, alignment: .top)
                                            .padding(.horizontal, 15)
                                            .padding(.vertical, 15)
                                            
                                            VStack(alignment: .leading) {
                                                Text(promptThreeText)
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.black)
                                                    .multilineTextAlignment(.leading)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .frame(maxHeight: .infinity, alignment: .bottom)
                                            .padding(.horizontal, 15)
                                            .padding(.vertical, 15)
                                        }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                        }
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding(.vertical, 15)
                    }
                }
            }
            .onAppear {
                getBackgroundColor()
            }
            .onChange(of: selectedPromptCategory) {
                setPrompts()
            }
            .fullScreenCover(isPresented: $showRegularPrompt) {
                AddJournalEntryView(isPresented: $isPresented)
            }
            .fullScreenCover(isPresented: $showPromptEntryView) {
                JournalEntryWithPromptView(prompt: $selectedPrompt, isPresented: $isPresented)
            }
            .preferredColorScheme(.dark)
        }
    }
    
    func getBackgroundColor() {
        
        /* Sets the prompts background by generating random numbers
           and with that number, creating an index to remove those colors
           from the arrays. */
        
        var lights = colors
        var darks = darkerColors
        var endNumber = 4
        var index = 0
        
        repeat {
            let randomNumber = Int.random(in: 0..<endNumber)
            
            switch endNumber {
            case 4:
                // When endNumber is 4, generate card one colors.
                promptOneColor = lights[randomNumber]
                promptOneColorTwo = darks[randomNumber]
                
                index = lights.firstIndex(of: promptOneColor)!
            case 3:
                // When endNumber is 3, generate card two colors.
                promptTwoColor = lights[randomNumber]
                promptTwoColorTwo = darks[randomNumber]
                
                index = lights.firstIndex(of: promptTwoColor)!
            case 2:
                // When endNumber is 2, generate card three colors.
                promptThreeColor = lights[randomNumber]
                promptThreeColorTwo = darks[randomNumber]
                
                index = lights.firstIndex(of: promptThreeColor)!
            default:
                print("END")
            }
            
            /* With the current index, remove that color to prevent dupes and
               decrement endNumber to go to the next case. */
            
            lights.remove(at: index)
            darks.remove(at: index)
            endNumber -= 1
        } while endNumber > 1
    }
    
    func setPrompts() {
        
        /* Function that sets prompts based on the selected
           picker item. */
        
        let randomNumberOne = Int.random(in: 0..<10)
        let randomNumberTwo = Int.random(in: 0..<10)
        let randomNumberThree = Int.random(in: 0..<10)
       
        
        switch selectedPromptCategory {
        case "Mindfulness":
            promptOneText = prompts.mindfulnessPrompts[randomNumberOne]
            promptTwoText = prompts.mindfulnessPrompts[randomNumberTwo]
            promptThreeText = prompts.mindfulnessPrompts[randomNumberThree]
        case "Simple":
            promptOneText = prompts.simplePrompts[randomNumberOne]
            promptTwoText = prompts.simplePrompts[randomNumberTwo]
            promptThreeText = prompts.simplePrompts[randomNumberThree]
        case "Self-Soothing":
            promptOneText = prompts.selfSoothingPrompts[randomNumberOne]
            promptTwoText = prompts.selfSoothingPrompts[randomNumberTwo]
            promptThreeText = prompts.selfSoothingPrompts[randomNumberThree]
        case "Gratitude":
            promptOneText = prompts.gratitudePrompts[randomNumberOne]
            promptTwoText = prompts.gratitudePrompts[randomNumberTwo]
            promptThreeText = prompts.gratitudePrompts[randomNumberThree]
        default:
            print("Something went wrong!")
        }
    }
}

#Preview {
    JournalEntryTypeView(isPresented: .constant(true))
}
