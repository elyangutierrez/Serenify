//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/30/24.
//

import SwiftUI

struct ExerciseEightCapsule: View {
    @State private var isPresented = false
    var geometryWidth: CGFloat
    
    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 30.0)
                    .fill(LinearGradient(colors: [Color("pastelGreen"), Color("darkerPastelGreen")], startPoint: .top, endPoint: .bottom))
                    .frame(width: geometryWidth, height: 150)
                    .overlay {
                        VStack {
                            HStack {
                                Text("03")
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
                            Text("Rainbow")
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
                ExerciseEightView(isPresented: $isPresented, backgroundColor: "pastelGreen")
            }
        }
    }
}

#Preview {
    ExerciseEightCapsule(geometryWidth: 400)
}
