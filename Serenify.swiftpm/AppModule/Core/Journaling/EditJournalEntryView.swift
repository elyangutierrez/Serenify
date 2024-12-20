//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/5/24.
//

import SwiftUI

struct EditJournalEntryView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Bindable var journalEntry: Entry
    
    @State private var editedJournal = false
    @State private var failedToEditJournal: Bool = false
    @State private var hapticsManager = HapticsManager()
    @State private var failedToDismiss = false
    
//    let date = Date.now
    
    var getDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: journalEntry.date)
    }
    
    var getMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM."
        return formatter.string(from: journalEntry.date)
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
                                TextField("Journal Title", text: $journalEntry.title, prompt: Text("Journal Title").foregroundStyle(Color("lighterGray")), axis: .vertical)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .tint(Color("lighterGray"))
                                    .foregroundStyle(.white)
                                    .frame(width: g.size.width * 0.9)
                                    .lineLimit(1...3)
                                
                                Rectangle()
                                    .fill(Color("lightGray"))
                                    .frame(width: g.size.width * 0.9, height: 0.5)
                            }
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 15)
                            
                            VStack {
                                TextField("Journal Body", text: $journalEntry.body, prompt: Text("Write your journal entry here...").foregroundStyle(Color("lightGray")), axis: .vertical)
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
                        
                        if (journalEntry.title.isEmpty || journalEntry.title == "") || (journalEntry.body.isEmpty || journalEntry.body == "") {
                            failedToDismiss.toggle()
                        } else {
                            dismiss()
                        }
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
                    Text("Edit Entry")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        let journalEntry = Entry(title: journalEntry.title, body: journalEntry.body, colorHighlight: journalEntry.colorHighlight, date: journalEntry.date)
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
        .alert("Journal Entry Edited", isPresented: $editedJournal) {
            Button("Ok", role: .cancel, action: {
                hapticsManager.editJournalEntry()
                dismiss()
            })
        } message: {
            Text("Your journal entry has been successfully edited!")
        }
        .alert("Failed To Add Journal", isPresented: $failedToEditJournal) {
            Button("Ok", role: .cancel, action: {
                hapticsManager.failedToEditJournalEntry()
            })
        } message: {
            Text("Your journal entry couldn't be edited. Check that you've filled in both the title and body.")
        }
        .alert("Couldn't Dismiss Window", isPresented: $failedToDismiss) {
            Button("Ok", role: .cancel) { }
        } message: {
            Text("Make sure that both the title and body are not empty.")
        }
    }
    
    func addEntryToJournals(_ entry: Entry) {
        if (entry.title.isEmpty || entry.title == "") || (entry.body.isEmpty || entry.body == "") {
            failedToEditJournal.toggle()
        } else {
            do {
                try modelContext.save()
                editedJournal.toggle()
            } catch {
                print("Failed to save journal entry.")
                failedToEditJournal.toggle()
            }
        }
    }
}

#Preview {
    EditJournalEntryView(journalEntry: Entry(title: "1st Entry", body: "Some journal entry text here.. Or not!", colorHighlight: "pastelBlue", date: Date.now))
}
