//
//  File.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/19/24.
//

import Foundation

@Observable
class DateManager {
    
    var currentMonth = ""
    var weekDayNames: [String] = []
    var weekDayDates: [Date] = []
    var currentDay: String = ""
    var selectedDay: String = ""
    
    func getCurrentMonth() {
        let calendar = Calendar.current
        let today = Date()
        let calendarMonth = calendar.component(.month, from: today)
        let stringForm = String(calendarMonth)
        
        switch stringForm {
        case "1":
            currentMonth = "January"
        case "2":
            currentMonth = "February"
        case "3":
            currentMonth = "March"
        case "4":
            currentMonth = "April"
        case "5":
            currentMonth = "May"
        case "6":
            currentMonth = "June"
        case "7":
            currentMonth = "July"
        case "8":
            currentMonth = "August"
        case "9":
            currentMonth = "September"
        case "10":
            currentMonth = "October"
        case "11":
            currentMonth = "November"
        case "12":
            currentMonth = "December"
        default:
            currentMonth = "Error"
        }
    }
    
    func getWeekDayNames() {
        let calendar = Calendar.current
        weekDayNames = calendar.shortWeekdaySymbols
    }
    
    func getWeekDayDates() {
        let calendar = Calendar.current
        let today = Date()
        
        let weekDay = calendar.component(.weekday, from: today)
        
        let daysToSunday = weekDay - calendar.firstWeekday
        
        let startOfWeek = calendar.date(byAdding: .day, value: -daysToSunday, to: today)!
        
        var currentWeek: [Date] = []
        for i in 0..<7 {
            if let day = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                currentWeek.append(day)
            }
        }
        
        weekDayDates = currentWeek
    }
    
    func getCurrentDay() {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        let item = formatter.string(from: today)
        currentDay = item
    }
}
