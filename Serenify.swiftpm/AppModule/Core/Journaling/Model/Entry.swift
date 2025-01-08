//
//  File.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/4/24.
//

import Foundation
import SwiftData

@Model
class Entry {
    var id = UUID()
    var title: String
    var body: String
    var colorHighlight: String
    var date: Date
    var isEditing: Bool
    var isFavorited: Bool
    
    init(id: UUID = UUID(), title: String, body: String, colorHighlight: String, date: Date) {
        self.id = id
        self.title = title
        self.body = body
        self.colorHighlight = colorHighlight
        self.date = date
        self.isEditing = false
        self.isFavorited = false
    }
    
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
    
    var formatTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

