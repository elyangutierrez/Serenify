//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/6/24.
//

import SwiftUI

struct JournalEntryWithPromptView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Binding var prompt: String
    @Binding var isPresented: Bool
    
    @State private var journalBody: String = ""
    @State private var addedJournal = false
    @State private var failedToAddJournal: Bool = false
    @State private var hapticsManager = HapticsManager()
    @State private var selectedPrompt = ""
    
    let date = Date.now
    let colors = ["pastelBlue", "pastelGreen", "pastelGold", "pastelPink"]
    
    var getDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: date)
    }
    
    var getMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM."
        return formatter.string(from: date)
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { g in
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    ScrollView {
                        VStack {
                            
                            VStack {
                                HStack {
                                    Text(getDay)
                                        .font(.system(size: 50))
                                        .fontDesign(.serif)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                    
                                    Text(getMonth)
                                        .foregroundStyle(.white)
                                        .offset(y: 12)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 15)
                            .background {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .fill(.thinMaterial)
                                    .frame(width: g.size.width * 0.93)
                            }
                            
                            Spacer()
                                .frame(height: 20)
                            
                            VStack(alignment: .leading) {
                                // TODO: Make this a regular text
                                
                                Text(prompt)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .lineLimit(1...3)
                            }
                            .frame(width: g.size.width * 0.9, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 15)
                            
                            Rectangle()
                                .fill(Color("lightGray"))
                                .frame(width: g.size.width * 0.9, height: 0.5)
                            
                            VStack {
                                TextField("Journal Body", text: $journalBody, prompt: Text("Write your journal entry here...").foregroundStyle(Color("lightGray")), axis: .vertical)
                                    .tint(Color("lightGray"))
                                    .frame(width: g.size.width * 0.9)
                                    .lineLimit(1...25)
                            }
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 15)
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isPresented = false
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
                
                ToolbarItem(placement: .principal) {
                    Text("Create Entry")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        let randomInt = Int.random(in: 0..<4)
                        let journalEntry = Entry(title: prompt, body: journalBody, colorHighlight: colors[randomInt], date: date)
                        addEntryToJournals(journalEntry)
                    }) {
                        Circle()
                            .fill(.thinMaterial)
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                            }
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
        .alert("Added Journal", isPresented: $addedJournal) {
            Button("Ok", role: .cancel, action: {
                hapticsManager.addJournalEntry()
                resetParameters()
                isPresented = false
            })
        } message: {
            Text("Your journal entry has been added!")
        }
        .alert("Failed To Add Journal", isPresented: $failedToAddJournal) {
            Button("Ok", role: .cancel, action: {
                hapticsManager.failedToAddJournalEntry()
            })
        } message: {
            Text("Your journal entry couldn't be added. Check that you've filled in both the title and body.")
        }
    }
    
    func addEntryToJournals(_ entry: Entry) {
        if (entry.title.isEmpty || entry.title == "") || (entry.body.isEmpty || entry.body == "") {
            failedToAddJournal.toggle()
        } else {
            modelContext.insert(entry)
            addedJournal.toggle()
        }
    }
    
    func resetParameters() {
        journalBody = ""
    }
}

#Preview {
    JournalEntryWithPromptView(prompt: .constant("Write down five things you can see, four you can feel, three you can hear, two you can smell, and one you can taste."), isPresented: .constant(true))
}
