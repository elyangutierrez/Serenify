//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/9/24.
//

import SwiftUI

struct ProgressBarView: View {
    
    var width: CGFloat
    var current: TimeInterval
    var total: TimeInterval
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15.0)
                .fill(.ultraThinMaterial)
                .frame(width: width, height: 5)
            RoundedRectangle(cornerRadius: 15.0)
                .frame(width: width * (current / total), height: 5)
                .animation(.smooth, value: Double(current / total))
                .shadow(color: .white, radius: 5)
//                .shadow(color: .white, radius: 2.5)
        }
    }
}

#Preview {
    ProgressBarView(width: 350, current: 148.0, total: 245.0)
}
