//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 10/30/24.
//

import SwiftUI

struct ExerciseOneCapsule: View {
    
    @State private var isPresented: Bool = false
    var geometryWidth: CGFloat
    
    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 30.0)
                    .fill(Color("pastelGreen"))
                    .frame(width: geometryWidth * 0.42, height: 175)
                    .overlay {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("45")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Text("Secs")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color("darkGray"))
                                    .offset(x: -4, y: 4)
                            }
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 15)
                        
                        VStack(alignment: .leading) {
                            Text("4-7-8")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Breathing")
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
                ExerciseOneView(isPresented: $isPresented, backgroundColor: "pastelGreen")
            }
        }
    }
}

#Preview {
    ExerciseOneCapsule(geometryWidth: 400)
}
