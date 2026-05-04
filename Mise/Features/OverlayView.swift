//
//  OverlayView.swift
//  Mise
//
//  Created by Edbert Leopard on 02/05/26.
//

import SwiftUI

struct OverlayView: View {
    
    let boxes: [CGRect] = []
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            CameraView()

            VStack {
                // --- TOP BAR ---
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .padding(30)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                    }) {
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
                    // Placeholder button untuk gallery preview
                    Button(action: {
                    }) {
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

//#Preview {
//    ZStack {
//        Color.gray.ignoresSafeArea()
//        OverlayView(boxes:)
//    }
//}
