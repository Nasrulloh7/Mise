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
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("testImage")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                
                if isProcessing {
                    ProgressView("Analyzing...")
                }
                
                Button("Detect") {
                    detectItem()
                }
            }
            .padding()
            .navigationDestination(isPresented: $navigate) {
                destinationView()
            }
        }
    }
    
    @ViewBuilder
    func destinationView() -> some View {
        if let count = detectedObject {
            OverlayView(count: count)
        } else {
            Text("No data")
        }
    }

    func detectItem() {
        guard let image = UIImage(named: "testImage") else { return }
        
        isProcessing = true
        
        ObjectDetection.detectObject(from: image) { count in
            DispatchQueue.main.async {
                detectedObject = count
                isProcessing = false
                navigate = true
            }
        }
    }
}

#Preview {
    AIView()
}
