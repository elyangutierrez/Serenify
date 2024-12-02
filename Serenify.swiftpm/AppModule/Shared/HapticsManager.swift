//
//  File.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/31/24.
//

import Foundation

@Observable
class HapticsManager {
    var haptics = Haptics()
    
    @MainActor func roundChange() {
        haptics.notify(.success)
    }
    
    @MainActor func addJournalEntry() {
        haptics.notify(.success)
    }
    
    @MainActor func failedToAddJournalEntry() {
        haptics.notify(.error)
    }
    
    @MainActor func deleteJournalEntry() {
        haptics.notify(.success)
    }
    
    @MainActor func cancel() {
        haptics.play(.light)
    }
    
    @MainActor func editJournalEntry() {
        haptics.notify(.success)
    }
    
    @MainActor func failedToEditJournalEntry() {
        haptics.notify(.error)
    }
    
    @MainActor func tappedMoodEmoji() {
        haptics.play(.soft)
    }
    
    @MainActor func submittedMood() {
        haptics.play(.light)
    }
    
    @MainActor func calenderMonthChanged() {
        haptics.play(.soft)
    }
    
    @MainActor func pickerYearChanged() {
        haptics.play(.soft)
    }
}
