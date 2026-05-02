//
//  CameraView.swift
//  Mise
//
//  Created by M Ilmi Nasrulloh on 02/05/26.
//

import SwiftUI

struct CameraView: View {
    var body: some View {
        VStack {
            Image(systemName: "applelogo")
                .frame(width: 100, height: 100)
                .background(Color.gray)
                .cornerRadius(50)
                .imageScale(.large)
                .scaledToFill()
                .font(Font.largeTitle.bold())
            Text("Hello, Apple!")
        }
        .padding()
    }
}

#Preview {
    CameraView()
}
