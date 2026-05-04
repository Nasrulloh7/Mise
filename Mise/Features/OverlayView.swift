//
//  OverlayView.swift
//  Mise
//
//  Created by M Ilmi Nasrulloh on 02/05/26.
//

import SwiftUI

struct OverlayView: View {
    
    let count: Int
    
    var body: some View {
        Text("\(count) object")
    }
}

#Preview {
    OverlayView(count: 1) // nanti ke update berdasarkan jumlah object yang kedetect
}
