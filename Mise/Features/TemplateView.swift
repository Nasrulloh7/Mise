//
//  TemplateView.swift
//  Mise
//
//  Created by M Ilmi Nasrulloh on 02/05/26.
//

import SwiftUI

struct TemplateView: View {
    
    let count: Int
    
    var availableTemplates: [TemplateEntry] {
        let safeCount = min(count, 3)
        return TemplateEntry.allTemplates.filter { $0.objectCount == safeCount }
        
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                VStack(spacing: 8) {
                    Text("Select a Template")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("Choose a template that matches your style and brings your vision to life.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(availableTemplates) { entry in
                            
                            NavigationLink(destination: OverlayView(selectedTemplate: entry)) {
                                TemplateCard(entry: entry)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    TemplateView(count: 3)
}
