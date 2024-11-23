//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/29/24.
//

import SwiftData
import SwiftUI

struct ViewNavigator: View {
    
    @Query var moods: [Mood]
    @Query var entries: [Entry]
    
    var body: some View {
        TabView {
            Group {
                HomeView(moods: moods, entries: entries)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                InsightsView(moods: moods, entries: entries)
                    .tabItem {
                        Label("Insights", systemImage: "chart.bar.xaxis")
                    }
            }
            .toolbarBackground(Color("darkerGray").opacity(0.97), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
        .tint(UIDevice.current.userInterfaceIdiom == .phone ? .white : .black)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ViewNavigator()
}
