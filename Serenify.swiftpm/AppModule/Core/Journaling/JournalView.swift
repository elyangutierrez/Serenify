//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/4/24.
//

import SwiftData
import SwiftUI

struct JournalView: View {
    @Environment(\.modelContext) var modelContext
    
    @AppStorage("notifications") var notificationsIsOn = false
    @AppStorage("time") var notificationsTime = ""
    
    @State private var hapticsManager = HapticsManager()
    @State private var showEntrySheet = false
    @State private var scale: CGFloat = 1.0
    @State private var selectedSortingOption = "Sort by Date"
    @State private var showDeletionAlert = false
    @State private var selectedEntry: Entry?
    @State private var failedToDeleteEntry = false
    @State private var journalEntryDeleted = false
    @State private var entryBeingEdited: Entry?
    @State private var showTimeAlert = false
    @State private var usersSelectedDate = Date()
    @State private var notificationsModel = NotificationsModel()
    @State private var sendNotification: Bool = false
    @State private var notificationsCancelled: Bool = false
    @State private var currentMonthAndYear = Date.now
    @State private var datePickerIsPresented: Bool = false
    
    let sortingOptions = ["Sort by Date", "Sort by Title"].sorted()
    let months = Calendar.current.shortMonthSymbols
    
    let columns = [GridItem(.adaptive(minimum: 80))]
    
    var entries: [Entry]
    
    var currentMonthResults: [Entry] {
        var placeholder = [Entry]()
        let monthAndYear = currentMonthAndYear.formattedDate(date: currentMonthAndYear)
        
        for entry in entries {
            let entryMonthAndYear = entry.date.formattedDate(date: entry.date)
            
            if monthAndYear == entryMonthAndYear {
                placeholder.append(entry)
            }
        }
        
        return placeholder
    }
    
    var sortedResults: [Entry] {
        if selectedSortingOption == "Sort by Date" {
            return currentMonthResults.sorted(by: { $0.date > $1.date })
        } else {
            return currentMonthResults.sorted(by: { $0.title.lowercased() < $1.title.lowercased() } )
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
                            if !sortedResults.isEmpty {
                                
                                VStack {
                                    HStack {
                                        VStack {
                                            let formattedDate = currentMonthAndYear.formattedDate(date: currentMonthAndYear)
                                            Text(formattedDate)
                                                .font(.title3)
                                                .fontWeight(.bold)
                                        }
                                        
                                        VStack {
                                            Button(action: {
                                                // show sheet that presents datepicker with confirm button
                                                datePickerIsPresented.toggle()
                                            }) {
                                                Image(systemName: "chevron.down")
                                                    .fontWeight(.bold)
                                            }
                                        }
                                    }
                                }
                                .frame(maxHeight: .infinity, alignment: .top)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 15)
                                
                                Spacer()
                                    .frame(height: 25)
                                
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
                            
//                            ForEach(sortedResults, id: \.self) { entry in
//                                ZStack {
//                                    VStack(alignment: .leading) {
//                                        
//                                        HStack {
//                                            Text(entry.getDay)
//                                                .font(.title)
//                                                .fontWeight(.bold)
//                                                .foregroundStyle(.white)
//                                                .background {
//                                                    Rectangle()
//                                                        .fill(Color(entry.colorHighlight))
//                                                        .frame(width: 35, height: 10)
//                                                        .offset(y: 14)
//                                                }
//                                            
//                                            Text(entry.getMonth)
//                                                .foregroundStyle(.white)
//                                                .offset(y: 4)
//                                        }
//                                        
//                                        Spacer()
//                                            .frame(height: 20)
//                                        
//                                        // Title
//                                        Text(entry.title)
//                                            .font(.headline)
//                                        
//                                        Spacer()
//                                            .frame(height: 10)
//                                        
//                                        // Body
//                                        Text(entry.body)
//                                        
//                                        Rectangle()
//                                            .fill(Color("lightGray"))
//                                            .frame(maxWidth: g.size.width * 0.9, maxHeight: 0.5, alignment: .center)
//                                        
//                                        HStack {
//                                            VStack {
//                                                Text(entry.formatTime)
//                                                    .font(.subheadline)
//                                                    .fontWeight(.bold)
//                                                    .foregroundStyle(Color("lighterGray"))
//                                            }
//                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                            
//                                            Menu {
//                                                Section {
//                                                    Button(action: {
//                                                        entry.isEditing = true
//                                                        entryBeingEdited = entry
//                                                    }) {
//                                                        Label("Edit", systemImage: "pencil")
//                                                    }
//                                                }
//                                                
//                                                Section {
//                                                    Button(role: .destructive, action: {
//                                                        selectedEntry = entry
//                                                        showDeletionAlert.toggle()
//                                                    }) {
//                                                        Label("Delete", systemImage: "trash")
//                                                    }
//                                                }
//                                            } label: {
//                                                Circle()
//                                                    .fill(.clear)
//                                                    .frame(width: 30, height: 30)
//                                                    .overlay {
//                                                        Image(systemName: "ellipsis")
//                                                            .foregroundStyle(Color("lighterGray"))
//                                                            .fontWeight(.bold)
//                                                    }
//                                            }
//                                            .frame(maxWidth: .infinity, alignment: .trailing)
//                                        }
//                                        .offset(y: 3)
//                                    }
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .padding(.horizontal, 25)
//                                    .padding(.vertical, 15)
//                                }
//                                .frame(maxWidth: .infinity)
//                                .background {
//                                    RoundedRectangle(cornerRadius: 15.0)
//                                        .fill(.thinMaterial)
//                                        .frame(maxWidth: g.size.width * 0.95)
//                                }
//                            }
//                            
//                            Spacer()
//                                .frame(height: 25)
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
                            Button(action: {
                                notificationsIsOn.toggle()
                            }) {
                                Label(notificationsIsOn ? "Turn Off" : "Turn On", systemImage: notificationsIsOn ? "bell.slash.fill" : "bell.and.waves.left.and.right.fill")
                                    .onChange(of: notificationsIsOn) {
                                        if notificationsIsOn == true {
                                            notificationsModel.enableNotifications()
                                            showTimeAlert.toggle()
                                        } else {
                                            print("Why did this run??")
                                            notificationsModel.cancelDailyNotifications()
                                            
                                            // Alert
                                            notificationsCancelled.toggle()
                                        }
                                    }
                            }
                        } label: {
                            Image(systemName: notificationsIsOn ? "bell.and.waves.left.and.right.fill" : "bell.slash.fill")
                        }
                    }
                    
                    
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
                
                if currentMonthResults.isEmpty {
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
            .sheet(isPresented: $showEntrySheet) {
                JournalEntryTypeView(isPresented: $showEntrySheet)
            }
            .sheet(isPresented: $showTimeAlert) {
                VStack {
                    DatePicker("Select Time", selection: $usersSelectedDate, displayedComponents: .hourAndMinute)
                    
                    Spacer()
                        .frame(height: 15)
                    
                    Button(action: {
                        notificationsTime = convertTimeToString(date: usersSelectedDate)
                        if notificationsIsOn  {
                            // Clear any previous ones and set new one
                            print("Cancelling previous notifications!")
                            notificationsModel.cancelDailyNotifications()
                            
                            notificationsModel.dateFromUser = usersSelectedDate
                            
                            Task {
                                await notificationsModel.sendDailyNotifications()
                                print("Sent!")
                            }
                        }
                        showTimeAlert = false
                    }) {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color("lightGray"))
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .overlay {
                                Text("Set Time")
                            }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding()
                .presentationDetents([.height(150)])
                .presentationCornerRadius(15.0)
                .interactiveDismissDisabled()
                .onAppear {
                    usersSelectedDate = convertStringToDate(string: notificationsTime)
                    print("Set users selected date")
                }
            }
            .sheet(isPresented: $datePickerIsPresented) {
                GeometryReader { g in
                    VStack {
                        
                        // Year Picker
                        Spacer()
                            .frame(height: 15)
                        HStack {
                            Image(systemName: "chevron.left")
                                .fontWeight(.bold)
                                .onTapGesture {
                                    currentMonthAndYear = Calendar.current.date(byAdding: .year, value: -1, to: currentMonthAndYear)!
                                    hapticsManager.pickerYearChanged()
                                }
                            
                            let year = currentMonthAndYear.yearOnly(date: currentMonthAndYear)
                            Text(year)
                                .fontWeight(.bold)
                                .transition(.move(edge: .trailing))
                            
                            Image(systemName: "chevron.right")
                                .fontWeight(.bold)
                                .onTapGesture {
                                    currentMonthAndYear = Calendar.current.date(byAdding: .year, value: 1, to: currentMonthAndYear)!
                                    hapticsManager.pickerYearChanged()
                                }
                        }
                        .padding()
                        
                        // Months
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(months.indices, id: \.self) { item in
                                let month = currentMonthAndYear.monthOnly(date: currentMonthAndYear)
                                Text(months[item])
                                    .font(.headline)
                                    .frame(width: 60, height: 33)
                                    .bold()
                                    .background(months[item] == month ? Color("lightGray") : Color("darkGray"))
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        hapticsManager.calenderMonthChanged()
                                        let components = Calendar.current.dateComponents([.year], from: currentMonthAndYear)
                                        if let year = components.year {
                                            currentMonthAndYear = Calendar.current.date(from: DateComponents(year: year, month: item + 1))!
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                            .frame(height: 45)
                        
                        Button(action: {
                            datePickerIsPresented.toggle()
                        }) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("lightGray"))
                                .frame(maxWidth: g.size.width * 0.90, minHeight: 40, maxHeight: 40)
                                .padding()
                                .cornerRadius(8)
                                .overlay {
                                    Text("Done")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                }
                                .offset(y: -30)
                        }
                    }
                }
                .interactiveDismissDisabled()
                .presentationDetents([.height(300)])
                .presentationCornerRadius(25)
            }
            .fullScreenCover(item: $entryBeingEdited) { entry in
                EditJournalEntryView(journalEntry: entry)
            }
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
        .alert("Notifications Disabled", isPresented: $notificationsCancelled) {
            Button("Ok", role: .cancel) { }
        }
    }
    
    func deleteJournalEntry(_ entry: Entry) -> Bool {
        let index = entries.firstIndex(of: entry)
        
        guard index != nil else { return false }
        
        modelContext.delete(entry)
        return true
    }
    
    func convertTimeToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .full
        return formatter.string(from: date)
    }
    
    func convertStringToDate(string: String) -> Date {
        if string.isEmpty {
            return Date.now
        } else {
            let formatter = DateFormatter()
            formatter.timeStyle = .full
            return formatter.date(from: string)!
        }
    }
}

#Preview {
    JournalView(entries: [Entry]())
}
