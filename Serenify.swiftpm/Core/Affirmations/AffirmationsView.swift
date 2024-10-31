//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/29/24.
//

import SwiftUI

struct AffirmationsView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Text("Affirmations View")
                        .foregroundStyle(.white)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Affirmations")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    AffirmationsView()
}
