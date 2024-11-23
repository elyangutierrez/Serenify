//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/18/24.
//

import SwiftUI

struct InsightsView: View {
    @State private var moodDate = Date.now
    @State private var journalDate = Date.now
    @State private var currentDate = Date.now
    @State private var moodDays: [Date] = []
    @State private var journalDays: [Date] = []
    @State private var hapticsManager = HapticsManager()
    
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var moods: [Mood]
    var entries: [Entry]
    
    var body: some View {
        NavigationStack {
            GeometryReader { g in
                ScrollView(showsIndicators: false) {
                    VStack {
                        
                        VStack(alignment: .leading) {
                            Text("Mood Overview")
                                .font(.title3).bold()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                            .frame(height: 25)
                        
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
                                //                        .fontWeight(.black)
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
                                        .foregroundStyle(.gray.opacity(0.80))
                                        .frame(maxWidth: .infinity, minHeight: 40)
                                        .background(
                                            Circle()
                                                .foregroundStyle(
                                                    Date.now.startOfDay == day.startOfDay
                                                    ? Color(.gray.opacity(0.70))
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
                    }
                    
                    Spacer()
                        .frame(height: 25)
                    
                    VStack {
                        VStack(alignment: .leading) {
                            Text("Journal Overview")
                                .font(.title3).bold()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                            .frame(height: 25)
                        
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
                                    Text(day.formatted(.dateTime.day()))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.secondary)
                                        .frame(maxWidth: .infinity, minHeight: 40)
                                        .background(
                                            Circle()
                                                .foregroundStyle(
                                                    Date.now.startOfDay == day.startOfDay
                                                    ? Color(.gray.opacity(0.70))
                                                    : .gray.opacity(0.25)
                                                )
                                        )
                                        .overlay {
                                            // TODO: Have a journal icon over the days?
                                            
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
        }
    }
}

#Preview {
    InsightsView(moods: [Mood](), entries: [Entry]())
}
