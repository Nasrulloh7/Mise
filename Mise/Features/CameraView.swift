//
//  CameraView.swift
//  Mise
//
//  Created by M Ilmi Nasrulloh on 02/05/26.
//

import SwiftUI
import AVFoundation
import AVKit

struct CameraView: View {
    
    @StateObject private var camera = CameraManager()
    
    private var flashIcon: String {
        switch camera.flashMode {
        case .off: return "bolt.slash.fill"
        case .on: return "bolt.fill"
        case .auto: return "bolt.badge.automatic.fill"
        @unknown default: return "bolt.slash.fill"
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            CameraPreview(session: camera.session, cameraManager: camera)
                .aspectRatio(3.0 / 4.0, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .clipped()
            
            VStack {
                Button {
                    camera.toggleFlash()
                } label: {
                    Image(systemName: flashIcon)
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding()
                }
                
                Spacer()
                
                Button(action: {
                    camera.capturePhoto()
                }) {
                    Circle()
                        .strokeBorder(.white, lineWidth: 3)
                        .frame(width: 70, height: 70)
                        .overlay {
                            Circle()
                                .fill(.white)
                                .frame(width: 60, height: 60)
                        }
                }
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    CameraView()
}
