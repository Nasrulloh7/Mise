//
//  MiseApp.swift
//  Mise
//
//  Created by M Ilmi Nasrulloh on 27/04/26.
//

import SwiftUI

@main
struct MiseApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                VStack(spacing: 20) {
                    Text("Placeholder for the TemplateView while testing OverlayView")
                        .font(.headline)
                    
                    NavigationLink(destination: OverlayView(selectedTemplate: TemplateEntry.allTemplates.first(where: { $0.imageName == "RoT-01-02" }))) {
                        Text("Open Camera with Overlay")
                    }
                }
            }
        }
    }
}
