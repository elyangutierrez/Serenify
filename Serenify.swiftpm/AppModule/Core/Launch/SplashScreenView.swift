//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/25/24.
//

import SwiftUI

struct SplashScreenView: View {
    
    @Binding var isPresented: Bool
    
    @State private var scale: CGFloat = 0.8
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Image("coloredAppIcon")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                    .scaleEffect(scale)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.easeIn(duration: 0.5)) {
                                scale = 1.0
                            }
                        }
                    
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                            withAnimation(.easeOut(duration: 0.4)) {
                                isPresented = false
                            }
                        }
                    }
                    .background(Color.black)
            }
        }
    }
}

#Preview {
    SplashScreenView(isPresented: .constant(true))
}
