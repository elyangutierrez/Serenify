//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/18/24.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Query var moods: [Mood]
    @Environment(\.modelContext) var modelContext
    @State private var scale = 1.0
    @State private var selectedMoodStep = 20.0
    @State private var selectedMood = ""
    @State private var currentAffirmation = ""
    @State private var dateManager = DateManager()
    let positiveAffirmations = Affirmations()
    
    var body: some View {
        NavigationStack {
            GeometryReader { g in
                ScrollView {
                    
                    Spacer()
                        .frame(height: 15)
                    
                    VStack {
                        // days
                        HStack {
                            /* In order to iterate through both arrays, zip them both and wrap the
                               zip around an Array.*/
                            ForEach(Array(zip(dateManager.weekDayNames, dateManager.weekDayDates)), id: \.0) { name, date in
                                VStack {
                                    Text(name)
                                        .font(.subheadline)
                                        .fixedSize(horizontal: true, vertical: false)
                                    
                                    let dateString = {
                                        let formatter = DateFormatter()
                                        formatter.dateFormat = "d"
                                        return formatter.string(from: date)
                                    }()
                                    
                                    Circle()
                                        .stroke(dateManager.currentDay == dateString ? Color("pastelBlue") : .clear, lineWidth: 2)
                                        .fill(.regularMaterial)
                                        .frame(width: 35, height: 35)
                                        .overlay {
                                            if let mood = moods.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) } ) {
                                                Text(mood.emoji)
                                                    .font(.title)
                                            }
                                        }
                                }
                                
                                Spacer()
                                    .frame(width: 15)
                            }
                        }
                        .frame(height: 50)
                        .offset(x: 3)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                        .frame(height: 25)
                    
                    VStack {
                        Text("Check In")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 15)
                    .listRowSeparator(.hidden, edges: .all)
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(.regularMaterial)
                            .frame(width: g.size.width * 0.9, height: 170)
                            .overlay {
                                VStack {
                                    
                                    VStack {
                                        Text("How are you feeling today?")
                                            .font(.headline)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 15)
                                    
                                    // Main emojis 😃,🙂,😐,☹️,😭
                                    VStack {
                                        HStack {
                                            Text("😃")
                                                .font(.title)
                                                .scaleEffect(selectedMoodStep == 20.0 ? 1.3 : 1.0)
                                                .onTapGesture {
                                                    withAnimation(.easeInOut(duration: 0.15)) {
                                                        selectedMoodStep = 20.0
                                                        selectedMood = "😃"
                                                    }
                                                }
                                            Spacer()
                                                .frame(width: 30)
                                            
                                            Text("🙂")
                                                .font(.title)
                                                .scaleEffect(selectedMoodStep == 40.0 ? 1.3 : 1.0)
                                                .onTapGesture {
                                                    withAnimation(.easeInOut(duration: 0.15)) {
                                                        selectedMoodStep = 40.0
                                                        selectedMood = "🙂"
                                                    }
                                                }
                                            
                                            Spacer()
                                                .frame(width: 30)
                                            
                                            Text("😐")
                                                .font(.title)
                                                .scaleEffect(selectedMoodStep == 60.0 ? 1.3 : 1.0)
                                                .onTapGesture {
                                                    withAnimation(.easeInOut(duration: 0.15)) {
                                                        selectedMoodStep = 60.0
                                                        selectedMood = "😐"
                                                    }
                                                }
                                            
                                            Spacer()
                                                .frame(width: 30)
                                            
                                            Text("☹️")
                                                .font(.title)
                                                .scaleEffect(selectedMoodStep == 80.0 ? 1.3 : 1.0)
                                                .onTapGesture {
                                                    withAnimation(.easeInOut(duration: 0.15)) {
                                                        selectedMoodStep = 80.0
                                                        selectedMood = "☹️"
                                                    }
                                                }
                                            
                                            Spacer()
                                                .frame(width: 30)
                                            
                                            Text("😭")
                                                .font(.title)
                                                .scaleEffect(selectedMoodStep == 100.0 ? 1.3 : 1.0)
                                                .onTapGesture {
                                                    withAnimation(.easeInOut(duration: 0.15)) {
                                                        selectedMoodStep = 100.0
                                                        selectedMood = "😭"
                                                    }
                                                }
                                        }
                                    }
                                    .offset(y: -10)
                                    
                                    Button(action: {
                                        let mood = Mood(emoji: selectedMood, date: .now)
                                        addMood(mood: mood)
                                    }) {
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .fill(.ultraThinMaterial)
                                            .frame(width: g.size.width * 0.8, height: 35)
                                            .overlay {
                                                VStack {
                                                    Text("Submit")
                                                        .font(.headline)
                                                        .fontWeight(.bold)
                                                }
                                            }
                                            .offset(y: -5)
                                    }
                                }
//                                .frame(maxHeight: .infinity, alignment: .top)
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                        .frame(height: 25)
                    
                    // Place exercises here that are easy to use and do well
                    VStack {
                        Text("Positive Affirmations")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 15)
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(LinearGradient(colors: [Color("pastelBlue"), Color("darkerPastelBlue")], startPoint: .top, endPoint: .bottom))
                            .frame(width: g.size.width * 0.9, height: 125)
                            .overlay {
                                VStack {
                                    VStack {
                                        Image(systemName: "quote.bubble.fill.rtl")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                    }
                                    
                                    Spacer()
                                        .frame(height: 15)
                                    
                                    Text(currentAffirmation)
                                        .font(.title3)
                                        .fontDesign(.serif)
                                        .foregroundStyle(.black)
                                        .padding(.horizontal)
                                }
                            }
                            .onAppear {
                                getAffirmation()
                            }
                    }
                    
                    Spacer()
                        .frame(height: 25)
                    
                    VStack {
                        Text("Techniques")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 15)
                    
                    VStack {
                        NavigationLink(destination: BreathingView()) {
                            RoundedRectangle(cornerRadius: 15.0)
                                .fill(LinearGradient(colors: [Color("pastelGreen"), Color("darkerPastelGreen")], startPoint: .top, endPoint: .bottom))
                                .frame(width: g.size.width * 0.9, height: 80)
                                .overlay {
                                    VStack {
                                        HStack {
                                            VStack {
                                                Text("Breathing")
                                                    .font(.title3)
                                                    .fontWeight(.bold)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal, 15)
                                            
                                            VStack {
                                                Image(systemName: "wind")
                                                    .resizable()
                                                    .frame(width: 25, height: 25)
                                                    .fontWeight(.bold)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding(.horizontal, 15)
                                        }
                                    }
                                }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: JournalView()) {
                            RoundedRectangle(cornerRadius: 15.0)
                                .fill(LinearGradient(colors: [Color("pastelPink"), Color("darkerPastelPink")], startPoint: .top, endPoint: .bottom))
                                .frame(width: g.size.width * 0.9, height: 80)
                                .overlay {
                                    VStack {
                                        HStack {
                                            VStack {
                                                Text("Journaling")
                                                    .font(.title3)
                                                    .fontWeight(.bold)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal, 15)
                                            
                                            VStack {
                                                Image(systemName: "book.fill")
                                                    .resizable()
                                                    .frame(width: 25, height: 20)
                                                    .fontWeight(.bold)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding(.horizontal, 15)
                                        }
                                    }
                                }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: MeditationView()) {
                            RoundedRectangle(cornerRadius: 15.0)
                                .fill(LinearGradient(colors: [Color("pastelGold"), Color("darkerPastelGold")], startPoint: .top, endPoint: .bottom))
                                .frame(width: g.size.width * 0.9, height: 80)
                                .overlay {
                                    VStack {
                                        HStack {
                                            VStack {
                                                Text("Meditation")
                                                    .font(.title3)
                                                    .fontWeight(.bold)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal, 15)
                                            
                                            VStack {
                                                Image(systemName: "figure.mind.and.body")
                                                    .resizable()
                                                    .frame(width: 25, height: 25)
                                                    .fontWeight(.bold)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .padding(.horizontal, 15)
                                        }
                                    }
                                }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer()
                        .frame(height: 25)
                    
                    
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear {
                getDateMethods()
            }
        }
    }
    
    func getDateMethods() {
        dateManager.getWeekDayNames()
        dateManager.getWeekDayDates()
        dateManager.getCurrentDay()
        dateManager.getCurrentMonth()
//        dateManager.setSelectedDay()
    }
    
    func getAffirmation() {
        let length = positiveAffirmations.affirmations.count
        
        let randomIndex = Int.random(in: 0..<length)
        
        currentAffirmation = positiveAffirmations.affirmations[randomIndex]
    }
    
    func addMood(mood: Mood) {
        modelContext.insert(mood)
    }
}

#Preview {
    HomeView()
}
