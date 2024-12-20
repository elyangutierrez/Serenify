//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/18/24.
//

import Charts
import SwiftUI

struct InsightsView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var moodDate = Date.now
    @State private var journalDate = Date.now
    @State private var currentDate = Date.now
    @State private var moodDays: [Date] = []
    @State private var journalDays: [Date] = []
    @State private var hapticsManager = HapticsManager()
    @State private var currentMoodScrollItem = 0
    
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var moods: [Mood]
    var entries: [Entry]
    
    var checkinsInMonth: [Mood] {
        var validCheckIns: [Mood] = []
        let calender = Calendar.current
        
        for mood in moods {
            if calender.isDate(mood.date, equalTo: moodDate, toGranularity: .month) {
                validCheckIns.append(mood)
//                print("Mood Type: \(mood.type)")
            }
        }
        
        return validCheckIns
    }
    
    var chartData: [(name: String, count: Int, color: Color)] {
        let amazingCount = checkinsInMonth.filter { $0.type == 1 }.count
        let goodCount = checkinsInMonth.filter { $0.type == 2 }.count
        let neutralCount = checkinsInMonth.filter { $0.type == 3 }.count
        let sadCount = checkinsInMonth.filter { $0.type == 4 }.count
        let angryCount = checkinsInMonth.filter { $0.type == 5 }.count
        
        return [
            (name: "Amazing", count: amazingCount, color: Color(hex: 0x71EC96)),
            (name: "Good", count: goodCount, color: Color(hex: 0xF4D692)),
            (name: "Neutral", count: neutralCount, color: Color(hex: 0xD9D9D9)),
            (name: "Sad", count: sadCount, color: Color(hex: 0xA8AFF5)),
            (name: "Angry", count: angryCount, color: Color(hex: 0xFF9A9A))
        ]
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { g in
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Text("Mood Tracker")
                            .font(.title3).bold()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                        .frame(height: 25)
            
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            VStack {
                                HStack {
                                    VStack {
                                        Button(action: {
                                            // When pressed, decrease month by 1
                                            moodDate = moodDate.decreaseMonth(date: moodDate)
                                            hapticsManager.calenderMonthChanged()
                                        }) {
                                            Image(systemName: "chevron.left")
                                                .foregroundStyle(.white)
                                                .fontWeight(.bold)
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    VStack {
                                        // Month and year
                                        let formattedDate = moodDate.formattedDate(date: moodDate)
                                        Text(formattedDate)
                                            .font(.headline)
                                            .fixedSize(horizontal: true, vertical: false)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    
                                    VStack {
                                        Button(action: {
                                            // When pressed, increase month by 1
                                            moodDate = moodDate.increaseMonth(date: moodDate)
                                            hapticsManager.calenderMonthChanged()
                                        }) {
                                            Image(systemName: "chevron.right")
                                                .foregroundStyle(.white)
                                                .fontWeight(.bold)
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                
                                Spacer()
                                    .frame(height: 25)
                                
                                HStack {
                                    ForEach(daysOfWeek.indices, id: \.self) { index in
                                        Text(daysOfWeek[index])
                                            .foregroundStyle(.white)
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                                LazyVGrid(columns: columns) {
                                    ForEach(moodDays, id: \.self) { day in
                                        if day.monthInt != moodDate.monthInt {
                                            Text("")
                                        } else {
                                            Text(day.formatted(.dateTime.day()))
                                                .fontWeight(.bold)
                                                .foregroundStyle(.white.opacity(0.70))
                                                .frame(maxWidth: .infinity, minHeight: 40)
                                                .background(
                                                    Circle()
                                                        .foregroundStyle(
                                                            Date.now.startOfDay == day.startOfDay
                                                            ? Color(.gray.opacity(0.60))
                                                            : .gray.opacity(0.25)
                                                        )
                                                )
                                                .overlay {
                                                    if let mood = moods.first(where: { Calendar.current.isDate($0.date, inSameDayAs: day) }), let uiImage = mood.uiImage
                                                    {
                                                        
                                                        let image = Image(uiImage: uiImage)
                                                        
                                                        image
                                                            .resizable()
                                                            .frame(width: 30, height: 30)
                                                            .clipShape(Circle())
                                                    }
                                                }
                                        }
                                    }
                                }
                                
                                Rectangle()
                                    .fill(Color("darkerGray"))
                                    .frame(maxWidth: .infinity, minHeight: 20)
                                    .overlay {
                                        HStack {
                                            Circle()
                                                .fill(currentMoodScrollItem == 0 ? Color("lighterGray") : Color("darkGray"))
                                                .frame(width: 10, height: 10)
                                            
                                            Circle()
                                                .fill(currentMoodScrollItem == 1 ? Color("lighterGray") : Color("darkGray"))
                                                .frame(width: 10, height: 10)
                                        }
                                    }
                            }
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color("darkerGray"))
                            }
                            .containerRelativeFrame(.horizontal)
                            .onAppear {
                                currentMoodScrollItem = 0
                            }
                            
                            VStack {
                                
                                Rectangle()
                                    .fill(Color("darkerGray"))
                                    .frame(maxWidth: .infinity, minHeight: 305)
                                    .overlay {
                                        VStack {
                                            if checkinsInMonth.count >= 5 {
                                                VStack {
                                                    Text("Statistics")
                                                        .font(.headline)
                                                    
                                                    VStack {
                                                        Spacer()
                                                            .frame(height: 25)
                                                        
                                                        Chart {
                                                            ForEach(chartData, id: \.name) { item in
                                                                BarMark(x: .value("Mood", item.name), y: .value("Days", item.count))
                                                                    .foregroundStyle(item.color)
                                                                        
                                                            }
                                                        }
                                                        .frame(height: 175)
                                                    }
                                                    
                                                    Spacer()
                                                        .frame(height: 25)
                                                    
                                                    Text("You have checked in ^[\(checkinsInMonth.count) day](inflect: true) out of \(moodDate.numberOfDaysInMonth) days this month.")
                                                        .font(.headline)
                                                }
                                                .frame(maxHeight: .infinity, alignment: .top)
                                            } else {
                                                VStack {
                                                    ContentUnavailableView("No Record", systemImage: "list.bullet.clipboard", description: Text("Please check back when you have checked in for atleast 5 days.").font(.headline))
                                                }
                                            }
                                        }
                                        
                                    }
                                
                                Rectangle()
                                    .fill(Color("darkerGray"))
                                    .frame(maxWidth: .infinity, minHeight: 20)
                                    .overlay {
                                        HStack {
                                            Circle()
                                                .fill(currentMoodScrollItem == 1 ? Color("lighterGray") : Color("darkGray"))
                                                .frame(width: 10, height: 10)
                                            
                                            Circle()
                                                .fill(currentMoodScrollItem == 0 ? Color("lighterGray") : Color("darkGray"))
                                                .frame(width: 10, height: 10)
                                        }
                                    }
                            }
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color("darkerGray"))
                            }
                            .containerRelativeFrame(.horizontal)
                            .onAppear {
                                currentMoodScrollItem = 1
                            }
                        }
                    }
                    .scrollTargetBehavior(.paging)
                
                    Spacer()
                        .frame(height: 25)
                    
                    VStack(alignment: .leading) {
                        Text("Journal Overview")
                            .font(.title3).bold()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                        .frame(height: 25)
                    
                    
                    VStack {
                        HStack {
                            VStack {
                                Button(action: {
                                    // When pressed, decrease month by 1
                                    journalDate = journalDate.decreaseMonth(date: journalDate)
                                    hapticsManager.calenderMonthChanged()
                                }) {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(.white)
                                        .fontWeight(.bold)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack {
                                // Month and year
                                let formattedDate = journalDate.formattedDate(date: journalDate)
                                Text(formattedDate)
                                    .font(.headline)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                            VStack {
                                Button(action: {
                                    // When pressed, increase month by 1
                                    journalDate = journalDate.increaseMonth(date: journalDate)
                                    hapticsManager.calenderMonthChanged()
                                }) {
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.white)
                                        .fontWeight(.bold)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        
                        Spacer()
                            .frame(height: 25)
                        
                        HStack {
                            ForEach(daysOfWeek.indices, id: \.self) { index in
                                Text(daysOfWeek[index])
                                //                        .fontWeight(.black)
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        LazyVGrid(columns: columns) {
                            ForEach(journalDays, id: \.self) { day in
                                if day.monthInt != journalDate.monthInt {
                                    Text("")
                                } else {
                                    
                                    let result = setOpacity(currentDay: day)
                                    
                                    Text(day.formatted(.dateTime.day()))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white.opacity(0.70))
                                        .frame(maxWidth: .infinity, minHeight: 40)
                                        .opacity(result ? 0 : 1)
                                        .background(
                                            Circle()
                                                .foregroundStyle(
                                                    Date.now.startOfDay == day.startOfDay
                                                    ? Color(.gray.opacity(0.60))
                                                    : .gray.opacity(0.25)
                                                )
                                        )
                                        .overlay {
                                            if let entry = entries.first(where: { Calendar.current.isDate($0.date, inSameDayAs: day)}) {
                                                Image(systemName: "book.fill")
                                                    .resizable()
                                                    .frame(width: 25, height: 20)
                                                    .foregroundStyle(Color(entry.colorHighlight))
                                            }
                                        }
                                }
                            }
                        }
                        
                        Spacer()
                            .frame(height: 25)
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color("darkerGray"))
                    }
                }
            }
            .navigationTitle("Insights")
            .padding()
            .onAppear {
                moodDays = moodDate.calendarDisplayDays
                journalDays = journalDate.calendarDisplayDays
            }
            .onChange(of: moodDate) {
                moodDays = moodDate.calendarDisplayDays
            }
            .onChange(of: journalDate) {
                journalDays = journalDate.calendarDisplayDays
            }
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button(action: {
//                        addFakeData()
//                    }) {
//                        Image(systemName: "plus")
//                            .foregroundStyle(.white)
//                    }
//                }
//            }
        }
    }
    
    func setOpacity(currentDay: Date) -> Bool {
        if let _ = entries.first(where: { Calendar.current.isDate($0.date, inSameDayAs: currentDay)}) {
            return true
        } else {
            return false
        }
    }
    
//    func addFakeData() {
//        
//        let mood = Mood(type: 1, date: Date.now)
//        let oneDayFromNow = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
//        let mood2 = Mood(type: 2, date: oneDayFromNow)
//        let twoDayFromNow = Calendar.current.date(byAdding: .day, value: 2, to: Date.now)!
//        let mood3 = Mood(type: 3, date: twoDayFromNow)
//        let threeDayFromNow = Calendar.current.date(byAdding: .day, value:3, to: Date.now)!
//        let mood4 = Mood(type: 4, date: threeDayFromNow)
//        let fourDayFromNow = Calendar.current.date(byAdding: .day, value: 4, to: Date.now)!
//        let mood5 = Mood(type: 5, date: fourDayFromNow)
//        
//        modelContext.insert(mood)
//        modelContext.insert(mood2)
//        modelContext.insert(mood3)
//        modelContext.insert(mood4)
//        modelContext.insert(mood5)
//    }
}

#Preview {
    InsightsView(moods: [Mood](), entries: [Entry]())
}
