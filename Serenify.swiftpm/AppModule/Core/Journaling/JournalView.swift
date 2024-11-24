//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/4/24.
//

import SwiftData
import SwiftUI

struct JournalView: View {
    
    var entries: [Entry]
    
    @Environment(\.modelContext) var modelContext
    
    @State private var hapticsManager = HapticsManager()
    
    @State private var showEntrySheet = false
    @State private var scale: CGFloat = 1.0
    @State private var selectedSortingOption = "Sort by Date"
    @State private var showDeletionAlert = false
    @State private var selectedEntry: Entry?
    @State private var failedToDeleteEntry = false
    @State private var journalEntryDeleted = false
    @State private var entryBeingEdited: Entry?
    
    let sortingOptions = ["Sort by Date", "Sort by Title"].sorted()
    
    var sortedResults: [Entry] {
        if selectedSortingOption == "Sort by Date" {
            return entries.sorted(by: { $0.date > $1.date })
        } else {
            return entries.sorted(by: { $0.title.lowercased() < $1.title.lowercased() } )
        }
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { g in
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    
                    ScrollView(showsIndicators: false) {
                        
                        Spacer()
                            .frame(height: 25)
                        
                        LazyVStack {
                            ForEach(sortedResults, id: \.self) { entry in
                                
                                ZStack {
                                    VStack(alignment: .leading) {
                                        
                                        HStack {
                                            Text(entry.getDay)
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.white)
                                                .background {
                                                    Rectangle()
                                                        .fill(Color(entry.colorHighlight))
                                                        .frame(width: 35, height: 10)
                                                        .offset(y: 14)
                                                }
                                            
                                            Text(entry.getMonth)
                                                .foregroundStyle(.white)
                                                .offset(y: 4)
                                        }
                                        
                                        Spacer()
                                            .frame(height: 20)
                                        
                                        // Title
                                        Text(entry.title)
                                            .font(.headline)
                                        
                                        Spacer()
                                            .frame(height: 10)
                                        
                                        // Body
                                        Text(entry.body)
                                        
                                        Rectangle()
                                            .fill(Color("lightGray"))
                                            .frame(maxWidth: g.size.width * 0.9, maxHeight: 0.5, alignment: .center)
                                        
                                        HStack {
                                            VStack {
                                                Text(entry.formatTime)
                                                    .font(.subheadline)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(Color("lighterGray"))
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            Menu {
                                                Section {
                                                    Button(action: {
                                                        entry.isEditing = true
//                                                        let index = entries.firstIndex(of: entry)
//                                                        guard let index else { return }
//                                                        print("\(entries[index].title) is being edited! + \(entries[index].isEditing)")
                                                        entryBeingEdited = entry
                                                    }) {
                                                        Label("Edit", systemImage: "pencil")
                                                    }
                                                }
                                                
                                                Section {
                                                    Button(role: .destructive, action: {
                                                        selectedEntry = entry
                                                        showDeletionAlert.toggle()
                                                    }) {
                                                        Label("Delete", systemImage: "trash")
                                                    }
                                                }
                                            } label: {
                                                Circle()
                                                    .fill(.clear)
                                                    .frame(width: 30, height: 30)
                                                    .overlay {
                                                        Image(systemName: "ellipsis")
                                                            .foregroundStyle(Color("lighterGray"))
                                                            .fontWeight(.bold)
                                                    }
                                            }
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                        }
                                        .offset(y: 3)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 25)
                                    .padding(.vertical, 15)
                                }
                                .frame(maxWidth: .infinity)
                                .background {
                                    RoundedRectangle(cornerRadius: 15.0)
                                        .fill(.thinMaterial)
                                        .frame(maxWidth: g.size.width * 0.95)
                                }
                            }
                            
                            Spacer()
                                .frame(height: 25)
                        }
                        
                        Spacer()
                            .frame(height: 60)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Journaling")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                }
                
                if !entries.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("", selection: $selectedSortingOption) {
                                ForEach(sortingOptions, id: \.self) {
                                    Text($0)
                                }
                            }
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                        }
                    }
                }
            }
            .toolbarBackground(Color("darkerGray").opacity(0.97), for: .navigationBar)
            .overlay {
                
                if entries.isEmpty {
                    VStack {
                        ContentUnavailableView("No Journal Entries",
                                               systemImage: "square.and.pencil",
                                               description: Text("Tap the '+' to add an entry.")
                        )
                    }
                }
                
                VStack {
                    Circle()
                        .fill(Color("darkGray"))
                        .frame(width: 60, height: 60)
                        .overlay {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.white)
                        }
                        .scaleEffect(scale)
                        .onTapGesture {
                            scale = 0.9
                            withAnimation(.easeInOut(duration: 0.2)) {
                                scale = 1.0
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    showEntrySheet.toggle()
                                }
                            }
                        }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
//            .fullScreenCover(isPresented: $showEntrySheet) {
//                JournalEntryTypeView(isPresented: $showEntrySheet)
//            }
            .sheet(isPresented: $showEntrySheet) {
                JournalEntryTypeView(isPresented: $showEntrySheet)
            }
            .fullScreenCover(item: $entryBeingEdited) { entry in
                EditJournalEntryView(journalEntry: entry)
            }
//
        }
        .preferredColorScheme(.dark)
        .alert("Delete Journal Entry", isPresented: $showDeletionAlert) {
            Button("Yes", role: .destructive, action: {
                guard let selectedEntry else { return }
                let result = deleteJournalEntry(selectedEntry)
                
                if result {
                    journalEntryDeleted.toggle()
                } else {
                    failedToDeleteEntry.toggle()
                }
            })
            
            Button("Cancel", role: .cancel, action: {
                hapticsManager.cancel()
            })
        } message: {
            Text("Are you sure you want to delete this journal entry? Once deleted, there is no going back.")
        }
        .alert("Journal Entry Deleted", isPresented: $journalEntryDeleted) {
            Button("Ok", role: .cancel, action: {
                journalEntryDeleted = false
                hapticsManager.deleteJournalEntry()
            })
        } message: {
            Text("This journal entry has been successfully deleted.")
        }
        .alert("Failed To Delete Entry", isPresented: $failedToDeleteEntry) {
            Button("Ok", role: .destructive, action: {
                failedToDeleteEntry = false
            })
        } message: {
            Text("Your journal entry failed to delete. Please try again.")
        }
    }
    
    func deleteJournalEntry(_ entry: Entry) -> Bool {
        let index = entries.firstIndex(of: entry)
        
        guard index != nil else { return false }
        
        modelContext.delete(entry)
        return true
    }
}

#Preview {
    JournalView(entries: [Entry]())
}
