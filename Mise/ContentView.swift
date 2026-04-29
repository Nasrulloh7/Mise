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
            Image(systemName: "ggjj")
                .frame(width: 100, height: 100)
                .background(Color.blue)
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
    ContentView()
}
