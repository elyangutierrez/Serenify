//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/31/24.
//

import SwiftUI

struct ProgressCircleView: View {
    
    let progress: Double
        
        var body: some View {
            ZStack {
                Circle()
                    .stroke(
                        /*Color.gray.opacity(0.3)*/
                        .ultraThinMaterial.opacity(0.6),
                        lineWidth: 8
                    )
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.white,
                        style: StrokeStyle(
                            lineWidth: 8,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.smooth, value: progress)
            }
        }
}

#Preview {
    ProgressCircleView(progress: 0.8)
}
