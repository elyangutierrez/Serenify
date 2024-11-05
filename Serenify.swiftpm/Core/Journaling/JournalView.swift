//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/4/24.
//

import SwiftUI

struct JournalView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Text("Hello, World!")
                        .foregroundStyle(.white)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Journaling")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    JournalView()
}
