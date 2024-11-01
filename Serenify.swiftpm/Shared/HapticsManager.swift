//
//  File.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/31/24.
//

import Foundation

class HapticsManager: ObservableObject {
    @Published var haptics = Haptics()
    
    @MainActor func phaseChange() {
        haptics.notify(.success)
    }
}
