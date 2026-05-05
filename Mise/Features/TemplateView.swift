//
//  TemplateView.swift
//  Mise
//
//  Created by M Ilmi Nasrulloh on 02/05/26.
//

import SwiftUI

struct TemplateView: View {
    
    let count: Int
    let boxes: [CGRect]
    
    @State private var overviewEntries = SampleTemplates.templates
    @State private var overviewEntries2 = SampleTemplates2.templates2
    
    var body: some View {
        
        OverlayView(count: count, boxes: boxes)
        
        VStack(spacing: 20) {
            Text("Select a Template").font(.largeTitle).bold()
            Text("Choose a template that matches your style and brings your vision to life.")
                .multilineTextAlignment(.center)
            HStack{
                ForEach(overviewEntries) {
                    entry in TemplateCard(entry: entry)
                }
            }
            HStack{
                ForEach(overviewEntries2) {
                    entry in TemplateCard(entry: entry)
                }
            }
        }
    }
}

#Preview {
    TemplateView(count: 0, boxes: [])

}
