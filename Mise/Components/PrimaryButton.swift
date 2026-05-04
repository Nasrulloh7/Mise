//
//  PrimaryButton.swift
//  Mise
//
//  Created by Rachel Chen on 02/05/26.
//

import SwiftUI


struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(.white)
                .clipShape(Capsule())
        }
    }
}

#Preview {
    PrimaryButton(title: "Start", action: {})
        .padding()
        .background(Color.black)
}
