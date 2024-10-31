//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/30/24.
//

import SwiftUI

struct ExerciseSixCapsule: View {
    @State private var isPresented = false
    var geometryWidth: CGFloat
    
    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 30.0)
                    .fill(Color("pastelGold"))
                    .frame(width: geometryWidth, height: 150)
                    .overlay {
                        VStack {
                            HStack {
                                Text("01")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Text("Mins")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color("darkGray"))
                                    .offset(x: -4, y: 6)
                            }
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 15)
                        
                        VStack {
                            Text("Count Backward from 100 by 7s")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 15)
                    }
                    .onTapGesture {
                        isPresented.toggle()
                    }
            }
            .fullScreenCover(isPresented: $isPresented) {
                ExerciseSixView(isPresented: $isPresented, backgroundColor: "pastelGold")
            }
        }
    }
}

#Preview {
    ExerciseSixCapsule(geometryWidth: 400)
}
