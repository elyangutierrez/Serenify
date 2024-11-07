//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/29/24.
//

import SwiftUI

struct ViewNavigator: View {
    var body: some View {
        TabView {
            Group {
                BreathingView()
                    .tabItem {
                        Label("Breathing", systemImage: "figure")
                    }
                
                JournalView()
                    .tabItem {
                        Label("Journaling", systemImage: "book")
                    }
                
                MeditationView()
                    .tabItem {
                        Label("Meditation", systemImage: "figure.mind.and.body")
                    }
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
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
