//
//  TextArea.swift
//  Flashy
//
//  Created by Martin Novak on 28.12.2022..
//

import SwiftUI

struct TextArea: View {
    @Binding var text:String
    var placeholder:String
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
        UITextView.appearance().backgroundColor = .clear
    }
    var body: some View {
        ZStack (alignment: .topLeading){
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(.placeholderText))
                    .padding()
            }
            TextEditor(text: $text)
                .padding(4)
            
        }
        .font(.body)
        .background(.clear)
    }
}
