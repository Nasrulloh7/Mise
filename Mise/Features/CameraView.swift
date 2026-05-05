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
    @State private var aiNavigation: Bool = false
    
    private var flashIcon: String {
        switch camera.flashMode {
        case .off: return "bolt.slash.fill"
        case .on: return "bolt.fill"
        case .auto: return "bolt.badge.automatic.fill"
        @unknown default: return "bolt.slash.fill"
        }
    }
    
    var body: some View {
        NavigationStack {
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
            
            .onChange(of: camera.capturedImage) { newImage in
                if newImage != nil {
                    aiNavigation = true
                }
            }
            
            .navigationDestination(isPresented: $aiNavigation) {
                if let image = camera.capturedImage {
                    AIView(image: image.image)
                }
            }
        }
    }
}

#Preview {
    CameraView()
}
