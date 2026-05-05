//
//  OverlayView.swift
//  Mise
//
//  Created by M Ilmi Nasrulloh on 02/05/26.
//

import SwiftUI

struct OverlayView: View {
    
    let count: Int
    let boxes: [CGRect]
    
    var body: some View {
        Text("Count: \(count)")
        Text("Boxes: \(boxes.count)")
    }
}

#Preview {
    OverlayView(count: 1, boxes: [])
}
