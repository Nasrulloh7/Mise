//
//  TemplateEntry.swift
//  Mise
//
//  Created by M Ilmi Nasrulloh on 02/05/26.
//

import SwiftUI

struct TemplateEntry: Identifiable {
    let id: UUID = UUID()
    let title: String
    let imageName: String
}

enum SampleTemplates {
    static let templates: [TemplateEntry] = [
        TemplateEntry(
            title: "Rule of Thrids",
            imageName: "image1",
        ),
        TemplateEntry(
            title: "S-Curve",
            imageName: "testImage1",
        ),
        
    ]
        
    
}


enum SampleTemplates2 {
    static let templates2: [TemplateEntry] = [
        TemplateEntry(
            title: "Golden Triangle",
            imageName: "image1",
            
        ),TemplateEntry(
            title: "Diagonal",
            imageName: "image1",
        )
    ]
        
    
}

