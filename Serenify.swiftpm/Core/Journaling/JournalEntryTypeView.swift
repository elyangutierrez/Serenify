//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/6/24.
//

import SwiftUI

struct JournalEntryTypeView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var promptOneColor = ""
    @State private var promptOneColorTwo = ""
    @State private var promptTwoColor = ""
    @State private var promptTwoColorTwo = ""
    @State private var promptThreeColor = ""
    @State private var promptThreeColorTwo = ""
    @State private var selectedPromptCategory = "Simple"
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
                                print("Tapped button 1!")
                                print("Prompt One Text: \(promptOneText)")
                                selectedPrompt = promptOneText
                                print("Selected prompt: \(selectedPrompt)")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    showPromptEntryView.toggle()
                                }
                            }) {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .fill(LinearGradient(colors: [Color(promptOneColor), Color(promptOneColorTwo)], startPoint: .top, endPoint: .bottom))
                                    .frame(width: g.size.width * 0.95, height: 150)
                                    .onAppear {
                                        getBackgroundColor(1)
                                        setPrompts()
                                    }
                                    .overlay {
                                        
                                        VStack {
                                            Text("PROMPT")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundStyle(Color("darkGray"))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(maxHeight: .infinity, alignment: .top)
                                        .padding(.horizontal, 15)
                                        .padding(.vertical, 15)
                                        
                                        VStack(alignment: .leading) {
                                            Text(promptOneText)
                                                .font(.title3)
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
                                print("Tapped button 2!")
                                selectedPrompt = promptTwoText
                                print("Selected prompt: \(selectedPrompt)")
                                showPromptEntryView.toggle()
                            }) {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .fill(LinearGradient(colors: [Color(promptTwoColor), Color(promptTwoColorTwo)], startPoint: .top, endPoint: .bottom))
                                    .frame(width: g.size.width * 0.95, height: 150)
                                    .onAppear {
                                        getBackgroundColor(2)
                                        setPrompts()
                                    }
                                    .overlay {
                                        
                                        VStack {
                                            Text("PROMPT")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundStyle(Color("darkGray"))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(maxHeight: .infinity, alignment: .top)
                                        .padding(.horizontal, 15)
                                        .padding(.vertical, 15)
                                        
                                        VStack(alignment: .leading) {
                                            Text(promptTwoText)
                                                .font(.title3)
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
                                print("Tapped button 3!")
                                selectedPrompt = promptThreeText
                                print("Selected prompt: \(selectedPrompt)")
                                showPromptEntryView.toggle()
                            }) {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .fill(LinearGradient(colors: [Color(promptThreeColor), Color(promptThreeColorTwo)], startPoint: .top, endPoint: .bottom))
                                    .frame(width: g.size.width * 0.95, height: 150)
                                    .onAppear {
                                        getBackgroundColor(3)
                                        setPrompts()
                                    }
                                    .overlay {
                                        
                                        VStack {
                                            Text("PROMPT")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundStyle(Color("darkGray"))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(maxHeight: .infinity, alignment: .top)
                                        .padding(.horizontal, 15)
                                        .padding(.vertical, 15)
                                        
                                        VStack(alignment: .leading) {
                                            Text(promptThreeText)
                                                .font(.title3)
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
            .onChange(of: selectedPromptCategory) {
                setPrompts()
            }
            .sheet(isPresented: $showPromptEntryView) {
                let _ = print("Prompt on sheet: \(selectedPrompt)")
                JournalEntryWithPromptView(prompt: selectedPrompt)
            }
            .sheet(isPresented: $showRegularPrompt) {
                AddJournalEntryView()
            }
            .preferredColorScheme(.dark)
            .toolbar {
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
    
    func getBackgroundColor(_ promptNumber: Int) {
        
        /* Sets the prompts background color based on the given card number
           and with the use of a random int generator. */
        
        let randomNumber = Int.random(in: 0..<4)
        
        switch promptNumber {
        case 1:
            promptOneColor = colors[randomNumber]
            promptOneColorTwo = darkerColors[randomNumber]
        case 2:
            promptTwoColor = colors[randomNumber]
            promptTwoColorTwo = darkerColors[randomNumber]
        case 3:
            promptThreeColor = colors[randomNumber]
            promptThreeColorTwo = darkerColors[randomNumber]
        default:
            print("Something went wrong!")
        }
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
    JournalEntryTypeView()
}
