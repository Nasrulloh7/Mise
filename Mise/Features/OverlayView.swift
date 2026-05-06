//
//  OverlayView.swift
//  Mise
//
//  Created by Edbert Leopard on 02/05/26.
//

import SwiftUI
import AVFoundation

import SwiftUI
import AVFoundation

struct CameraInOverlay: View {
    
    @StateObject private var camera = CameraManager()
    @State private var aiNavigation: Bool = false
    
    @State private var isBlinking: Bool = false
    
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
                
                // Camera feed Layer
                CameraPreview(session: camera.session, cameraManager: camera)
                    .aspectRatio(3.0 / 4.0, contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .clipped()
                
                // Shutter blink layer, kalau pencet shutter button
                Color.black
                    .opacity(isBlinking ? 1.0 : 0.0)
                    .ignoresSafeArea()
                
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
                        // Trigger the shutter blink
                        withAnimation(.easeIn(duration: 0.05)) {
                            isBlinking = true
                        }
                        
                        // Fade it back out after 0.05 second
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            withAnimation(.easeOut(duration: 0.05)) {
                                isBlinking = false
                            }
                        }
                        
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
}


struct OverlayView: View {
    
    let selectedTemplate: TemplateEntry?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // 1. BASE LAYER: Camera feed
            CameraInOverlay()
            
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
                    Button(action: {
                        // Source - https://stackoverflow.com/a/46475444
                        // Posted by Jigar Thakkar
                        // Retrieved 2026-05-06, License - CC BY-SA 3.0
                        
                        UIApplication.shared.open(URL(string:"photos-redirect://")!)
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
