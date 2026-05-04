//
//  CameraPreview.swift
//  Mise
//
//  Created by M Ilmi Nasrulloh on 03/05/26.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {

    let session: AVCaptureSession
    let cameraManager: CameraManager

    func makeUIView(context: Context) -> PreviewView {
        let view = PreviewView()
        view.previewLayer.videoGravity = .resizeAspectFill
        view.previewLayer.session = session
        return view
    }

    func updateUIView(_ uiView: PreviewView, context: Context) {
        if uiView.previewLayer.session !== session {
            uiView.previewLayer.session = session
        }
    }
}

final class PreviewView: UIView {
    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }

    var previewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Expected AVCaptureVideoPreviewLayer")
        }
        return layer
    }
}
