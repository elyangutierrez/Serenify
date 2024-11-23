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
    var date: Date
    
    init(id: UUID = UUID(), emoji: Data? = nil, date: Date) {
        self.id = id
        self.emoji = emoji
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
}
