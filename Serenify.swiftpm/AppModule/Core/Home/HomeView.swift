//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/18/24.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var scale = 1.0
    @State private var selectedMoodStep = 20.0
    @State private var selectedMood: UIImage?
    @State private var currentAffirmation = ""
    @State private var dateManager = DateManager()
    @State private var dataManager = DataManager()
    @State private var hapticsManager = HapticsManager()
    @State private var typeNum = 0
    @State private var currentDateAndTime = Date.now
    @State private var affirmationsTop : Color = .black
    @State private var affirmationsBottom : Color = .black
    
    let positiveAffirmations = Affirmations()
    let coreColors: [Color] = [Color("pastelBlue"), Color("pastelGreen"), Color("pastelGold"), Color("pastelPink")]
    let darkerCoreColors : [Color] = [Color("darkerPastelBlue"), Color("darkerPastelGreen"), Color("darkerPastelGold"), Color("darkerPastelPink")]
    
    var moods: [Mood]
    var entries: [Entry]
    
    var getTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmmss"
        
        return dateFormatter.string(from: currentDateAndTime)
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { g in
                ScrollView(showsIndicators: false) {
                    
                    Spacer()
                        .frame(height: 15)
                    
                    VStack {
                        HStack {
                            /* In order to iterate through both arrays, zip them and wrap the
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
                                        .stroke(dateManager.currentDay == dateString ? Color("lighterGray") : .clear, lineWidth: 2)
                                        .fill(.regularMaterial)
                                        .frame(width: 35, height: 35)
                                        .overlay {
                                            if let mood = moods.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }), let uiImage = mood.uiImage
                                                {
                                                
                                                let image = Image(uiImage: uiImage)
                                                
                                                image
                                                    .resizable()
                                                    .frame(width: 25, height: 25)
                                                    .clipShape(Circle())
                                            }
                                        }
                                        .background {
                                            Color.clear
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
                                    
                                    Spacer()
                                        .frame(height: 25)
                                    
                                    VStack {
                                        HStack {
                                            Image("amazingFace")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .scaleEffect(selectedMoodStep == 20.0 ? 1.3 : 1.0)
                                                .onTapGesture {
                                                    selectedMoodStep = 20.0
                                                    selectedMood = UIImage(named: "amazingFace")
                                                    typeNum = 1
                                                    hapticsManager.tappedMoodEmoji()
                                                }
                                            Spacer()
                                                .frame(width: 30)
                                            
                                            Image("goodFace")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .scaleEffect(selectedMoodStep == 40.0 ? 1.3 : 1.0)
                                                .onTapGesture {
                                                    selectedMoodStep = 40.0
                                                    selectedMood = UIImage(named: "goodFace")
                                                    typeNum = 2
                                                    hapticsManager.tappedMoodEmoji()
                                                }
                                            
                                            Spacer()
                                                .frame(width: 30)
                                            
                                            Image("neutralFace")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .scaleEffect(selectedMoodStep == 60.0 ? 1.3 : 1.0)
                                                .onTapGesture {
                                                    selectedMoodStep = 60.0
                                                    selectedMood = UIImage(named: "neutralFace")
                                                    typeNum = 3
                                                    hapticsManager.tappedMoodEmoji()
                                                }
                                            
                                            Spacer()
                                                .frame(width: 30)
                                            
                                            Image("sadFace")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .scaleEffect(selectedMoodStep == 80.0 ? 1.3 : 1.0)
                                                .onTapGesture {
                                                    selectedMoodStep = 80.0
                                                    selectedMood = UIImage(named: "sadFace")
                                                    typeNum = 4
                                                    hapticsManager.tappedMoodEmoji()
                                                }
                                            
                                            Spacer()
                                                .frame(width: 30)
                                            
                                            Image("angryFace")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .scaleEffect(selectedMoodStep == 100.0 ? 1.3 : 1.0)
                                                .onTapGesture {
                                                    selectedMoodStep = 100.0
                                                    selectedMood = UIImage(named: "angryFace")
                                                    typeNum = 5
                                                    hapticsManager.tappedMoodEmoji()
                                                }
                                        }
                                    }
                                    
                                    Spacer()
                                        .frame(height: 25)
                                    
                                    Button(action: {
                                        guard let selectedMood else { return }
//                                        print("Got the selectedMood!") # DEBUG
                                        let data = dataManager.convertImageToData(image: selectedMood)
                                        guard let data else { return }
//                                        print("Got the data: \(data)") # DEBUG
                                        let mood = Mood(emoji: data, type: typeNum, date: .now)
                                        addMood(mood: mood)
                                        hapticsManager.submittedMood()
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
                                    }
                                }
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                        .frame(height: 25)
                    
                    VStack {
                        Text("Positive Affirmations")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 15)
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(LinearGradient(colors: [affirmationsTop, affirmationsBottom], startPoint: .top, endPoint: .bottom))
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
                                        .foregroundStyle(.white)
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
                        Text("Suggestions")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 15)
                    
                    VStack {
                        SuggestionsView(width: g.size.width * 0.85, currentTime: getTime)
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
                        
                        NavigationLink(destination: JournalView(entries: entries)) {
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
//                print(getTime) # DEBUG
            }
        }
    }
    
    func getDateMethods() {
        dateManager.getWeekDayNames()
        dateManager.getWeekDayDates()
        dateManager.getCurrentDay()
    }
    
    func getAffirmation() {
        let length = positiveAffirmations.affirmations.count
        
        let randomIndex = Int.random(in: 0..<length)
        
        currentAffirmation = positiveAffirmations.affirmations[randomIndex]
        
        let randomColorIndex = Int.random(in: 0..<coreColors.count)
        affirmationsTop = coreColors[randomColorIndex]
        affirmationsBottom = darkerCoreColors[randomColorIndex]
    }
    
    func addMood(mood: Mood) {
        
        /* If there is already an entry for the current date and a user wants
           to change that entry, then just save it. Else, insert it into the model
           context as a new entry. */
        let calender = Calendar.current
        if let existingItem = moods.first(where: { calender.isDate($0.date, inSameDayAs: mood.date)}) {
            existingItem.emoji = mood.emoji
            existingItem.type = mood.type
            DispatchQueue.main.async {
                do {
                    try modelContext.save()
                } catch {
                    print("Error saving: \(error.localizedDescription)")
                }
            }
        } else {
            modelContext.insert(mood)
        }
    }
}

#Preview {
    HomeView(moods: [Mood](), entries: [Entry]())
}
