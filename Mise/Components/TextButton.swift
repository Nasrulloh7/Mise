//
//  TextButton.swift
//  Mise
//
//  Created by Rachel Chen on 02/05/26.
//

import SwiftUI

struct TextButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(.white.opacity(0.7))
                .underline()
        }
    }
}

#Preview {
    TextButton(title: "Exit", action: {})
        .padding()
        .background(Color.black)
}
