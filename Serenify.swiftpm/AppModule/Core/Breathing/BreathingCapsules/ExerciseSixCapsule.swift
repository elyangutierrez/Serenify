//
//  SwiftUIView 2.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/4/24.
//

import SwiftUI

struct ExerciseSixCapsule: View {
    @State private var isPresented: Bool = false
    var geometryWidth: CGFloat
    var hapticsManager = HapticsManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 30.0)
                    .fill(LinearGradient(colors: [Color("pastelGold"), Color("darkerPastelGold")], startPoint: .top, endPoint: .bottom))
                    .frame(width: geometryWidth, height: 175)
                    .overlay {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("03")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                                Text("Mins")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color("darkGray"))
                                    .offset(x: -4, y: 4.5)
                            }
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 15)
                        
                        VStack(alignment: .leading) {
                            Text("1:2")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                            Text("Breathing")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                        }
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 15)
                    }
                    .onTapGesture {
                        hapticsManager.haptics.play(.light)
                        isPresented.toggle()
                    }
            }
            .fullScreenCover(isPresented: $isPresented) {
                ExerciseSixView(isPresented: $isPresented)
            }
        }
    }
}

#Preview {
    ExerciseSixCapsule(geometryWidth: 400)
}
