//
//  SwiftUIView.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 1/6/25.
//

import SwiftUI

// Toolbar on keyboard is very buggy so this will not be implemented :/

struct StylizedToolbarView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Done") {
                        print("Done!")
                    }
                }
            }
    }
}
