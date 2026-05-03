//
//  ObjectDetection.swift
//  Mise
//
//  Created by Kezia Karen Amelia on 03/05/26.
//

import SwiftUI
import Vision
import CoreML

class ObjectDetection {
    static func detectObject(from image: UIImage, completion: @escaping (Int) -> Void) { // nanti ganti parameter imagenya pakai hasil jepretan foto user
        
        guard let cgImage = image.cgImage else {
            completion(0)
            return
        }
        
        let model: VNCoreMLModel
        
        do {
            let config = MLModelConfiguration()
            let miseModel = try MiseDetectorModel(configuration: config)
            model = try VNCoreMLModel(for: miseModel.model)
        } catch {
            completion(0)
            return
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNRecognizedObjectObservation] else {
                completion(0)
                return
            }
            
            let count = results.count
            
            DispatchQueue.main.async {
                completion(count)
            }
        }
        
        request.imageCropAndScaleOption = .scaleFit
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        DispatchQueue.global().async {
            try? handler.perform([request])
        }
    }
}
