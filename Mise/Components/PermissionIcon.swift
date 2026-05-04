//
//  PermissionIcon.swift
//  Mise
//
//  Created by Rachel Chen on 02/05/26.
//

import SwiftUI

struct PermissionIcon: View {
    let systemName: String
    var size: CGFloat = 170

    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundStyle(.white)
    }
}

#Preview {
    VStack(spacing: 32) {
        PermissionIcon(systemName: "camera")
        PermissionIcon(systemName: "photo")
        PermissionIcon(systemName: "checkmark.circle")
    }
    .padding()
    .background(Color.black)
}
