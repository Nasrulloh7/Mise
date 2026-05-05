//
//  OverlayView.swift
//  Mise
//
//  Created by Edbert Leopard on 02/05/26.
//

import SwiftUI

struct OverlayView: View {
    
    let selectedTemplate: TemplateEntry?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // 1. BASE LAYER: Camera feed
            CameraView()

            // 2. TEMPLATE OUTLINES LAYER
            if let template = selectedTemplate {
                GeometryReader { geometry in
                    
                    let figmaToPointScale = geometry.size.width / TemplateEntry.figmaBaseWidth
                    
                    ForEach(template.guides) { guide in
                        
                        let centerFigmaX = guide.x + (guide.width / 2)
                        let centerFigmaY = guide.y + (guide.width / 2)
                        
                        let finalX = centerFigmaX * figmaToPointScale
                        let finalY = centerFigmaY * figmaToPointScale
                        let finalWidth = guide.width * figmaToPointScale
                        
                        Circle()
                            .stroke(Color.white, style: StrokeStyle(lineWidth: 2, dash: [8, 6]))
                            .frame(width: finalWidth)
                            .position(x: finalX, y: finalY)
                    }
                }
                .aspectRatio(3.0 / 4.0, contentMode: .fit)
                .allowsHitTesting(false)
            }

            // 3. UI CONTROLS LAYER
            VStack {
                // --- TOP BAR ---
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .padding(30)
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "questionmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.white.opacity(0.25))
                            .clipShape(Circle())
                            .padding(30)
                    }
                }
                .padding(.top, 10)
                
                Spacer()
                
                // --- BOTTOM BAR ---
                HStack {
                    Button(action: {}) {
                        Image("testImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                            )
                    }
                    .padding(.leading, 30)
                    .padding(.bottom, 40)
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OverlayView(count: 1, boxes: [])
}
