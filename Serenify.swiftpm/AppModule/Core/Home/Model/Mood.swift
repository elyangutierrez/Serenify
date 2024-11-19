//
//  File.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/19/24.
//

import Foundation
import SwiftData

@Model
class Mood {
    var id = UUID()
    var emoji: String
    var date: Date
    
    init(emoji: String, date: Date) {
        self.emoji = emoji
        self.date = date
    }
    
    var dateDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
}
