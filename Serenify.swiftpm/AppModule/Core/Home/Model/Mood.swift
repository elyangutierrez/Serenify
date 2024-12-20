//
//  File.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/19/24.
//

import Foundation
import SwiftData
import UIKit

@Model
class Mood {
    
    var id = UUID()
    var emoji: Data?
    var type: Int
    var date: Date
    
    init(id: UUID = UUID(), emoji: Data? = nil, type: Int, date: Date) {
        self.id = id
        self.emoji = emoji
        self.type = type
        self.date = date
    }
    
    var uiImage: UIImage? {
        if let data = emoji {
            let uiImage = UIImage(data: data)
            guard let uiImage else { return nil }
            return uiImage
        } else {
            return nil
        }
    }
    
    var dateDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
    
    func getAmazingCount(_ moods: [Mood]) -> Int {
        var placeholder = 0
        for mood in moods {
            if mood.type == 1 {
                placeholder += 1
            }
        }
        return placeholder
    }
    
    func getGoodCount(_ moods: [Mood]) -> Int {
        var placeholder = 0
        for mood in moods {
            if mood.type == 2 {
                placeholder += 1
            }
        }
        return placeholder
    }
    
    func getNeutralCount(_ moods: [Mood]) -> Int {
        var placeholder = 0
        for mood in moods {
            if mood.type == 3 {
                placeholder += 1
            }
        }
        return placeholder
    }
    
    func getSadCount(_ moods: [Mood]) -> Int {
        var placeholder = 0
        for mood in moods {
            if mood.type == 4 {
                placeholder += 1
            }
        }
        return placeholder
    }
    
    func getAngryCount(_ moods: [Mood]) -> Int {
        var placeholder = 0
        for mood in moods {
            if mood.type == 5 {
                placeholder += 1
            }
        }
        return placeholder
    }
}
