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
                
                ImageryView()
                    .tabItem {
                        Label("Imagery", systemImage: "photo")
                    }
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
            .toolbarBackground(.black.opacity(0.85), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
        .tint(UIDevice.current.userInterfaceIdiom == .phone ? .white : .black)
        .preferredColorScheme(.light)
    }
}

#Preview {
    ViewNavigator()
}
