//
//  AIView.swift
//  Mise
//
//  Created by Kezia Karen Amelia on 03/05/26.
//

import SwiftUI

struct AIView: View {
    
    @State private var detectedObject: Int? = nil
    @State private var isProcessing: Bool = false
    @State private var navigate = false
    @State private var boundingBoxes: [CGRect] = []
    @State private var isRotating: Bool = false
    
    let image: UIImage
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .blur(radius: 10)
                    .overlay(
                        Color.black.opacity(0.5)
                            .ignoresSafeArea()
                    )
                VStack(spacing: 20) {
                    Image("Logo Mise App")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .rotationEffect(.degrees(isRotating ? 360 : 0))
                        .animation(.linear(duration: 3).repeatForever(autoreverses: false), value: isRotating)
                    
                    Text("Analyzing...")
                        .foregroundStyle(.white)
                        .font(.headline)
                }
            }
            .onAppear() {
                isRotating = true
                detectItem()
            }
            
            .navigationDestination(isPresented: $navigate) {
                destinationView()
            }
        }
    }
    
    @ViewBuilder
    func destinationView() -> some View {
        if let count = detectedObject {
            TemplateView(count: count, boxes: boundingBoxes)
        } else {
            Text("No data")
        }
    }
    
    func detectItem() {
        isProcessing = true
        
        ObjectDetection.detectObject(from: image) { count, boxes in
            DispatchQueue.main.async {
                detectedObject = count
                boundingBoxes = boxes
                isProcessing = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    navigate = true
                }
            }
        }
    }
}

#Preview {
    AIView(image: UIImage(systemName: "photo")!)
}
