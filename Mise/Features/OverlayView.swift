//
//  OverlayView.swift
//  Mise
//
//  Created by M Ilmi Nasrulloh on 02/05/26.
//

import SwiftUI

struct OverlayView: View {
    
    let boxes: [CGRect]
    
    var body: some View {
        Text("Boxes: \(boxes.count)")
    }
}

#Preview {
    OverlayView(boxes: [])
}
