//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/30/24.
//

import SwiftUI

struct ExerciseFiveCapsule: View {
    
    @State private var isPresented = false
    var geometryWidth: CGFloat
    
    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 30.0)
                    .fill(LinearGradient(colors: [Color("pastelBlue"), Color("darkerPastelBlue")], startPoint: .top, endPoint: .bottom))
                    .frame(width: geometryWidth, height: 150)
                    .overlay {
                        VStack {
                            HStack {
                                Text("02")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Text("Mins")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color("darkGray"))
                                    .offset(x: -4, y: 4.6)
                            }
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 15)
                        
                        VStack {
                            Text("5-4-3-2-1")
                                .font(.title2)
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
                ExerciseFiveView(isPresented: $isPresented, backgroundColor: "pastelBlue")
            }
        }
    }
}

#Preview {
    ExerciseFiveCapsule(geometryWidth: 400)
}
