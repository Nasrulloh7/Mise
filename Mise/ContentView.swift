//
//  ContentView.swift
//  Mise
//
//  Created by M Ilmi Nasrulloh on 27/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "applelogo")
                .imageScale(.large)
                .scaledToFill()
                .font(Font.largeTitle.bold())
            Text("Hello, Apple!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
