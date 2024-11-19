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
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                InsightsView()
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
