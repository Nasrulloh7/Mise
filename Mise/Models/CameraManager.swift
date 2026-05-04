//
//  CameraManager.swift
//  Mise
//
//  Created by M Ilmi Nasrulloh on 03/05/26.
//

import SwiftUI
import AVFoundation
import Combine

class CameraManager: NSObject, ObservableObject {
    
    let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    private var currentInput: AVCaptureDevice?
    
    @Published var flashMode: AVCaptureDevice.FlashMode = .off
    @Published var capturedImage: IdentifiableImage?
    
    override init() {
        super .init()
        setupSession()
    }
    
    private func setupSession() {
        session.beginConfiguration()
        session.sessionPreset = .photo
        
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else {
            print("Failed to access camera")
            return
        }
        session.canAddInput(input)
        session.addInput(input)
        currentInput = device
        
        session.canAddOutput(output)
        session.addOutput(output)
        
        session.commitConfiguration()
        session.startRunning()
    }
    
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = self.flashMode
        
        output.capturePhoto(with: settings, delegate: self)
    }
    
    func toggleFlash() {
        flashMode = switch flashMode {
        case .off: .on
        case .on: .auto
        case .auto: .off
        @unknown default: .off
        }
    }

}

extension CameraManager: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {

        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data)
              else { return }

        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

struct IdentifiableImage: Identifiable {
    let id = UUID()
    let image: UIImage
}
