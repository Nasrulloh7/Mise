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
    
    var body: some View {
        Text("Count: \(count)")
        
        OverlayView(selectedTemplate: nil)
    }
}

#Preview {
    TemplateView(count: 1, boxes: [])
}
