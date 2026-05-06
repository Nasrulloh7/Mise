//
//  TemplateEntry.swift
//  Mise
//
//  Created by Edbert Leopard on 02/05/26.
//

import SwiftUI

// MARK: - Guide Positioning and Size
struct ObjectGuide: Identifiable {
    let id = UUID()
    let x: CGFloat
    let y: CGFloat
    let width: CGFloat
}

// MARK: - Template Model
struct TemplateEntry: Identifiable {
    var id: String { imageName }
    let title: String
    let imageName: String
    let objectCount: Int
    let guides: [ObjectGuide]
}

// MARK: - Template Database
extension TemplateEntry {
    
    // Ukuran template sesuai di Figma
    static let figmaBaseWidth: CGFloat = 1206.0
    static let figmaBaseHeight: CGFloat = 1608.0
    
    static let allTemplates: [TemplateEntry] = [
        
        // --- DIAGONAL (Dg) ---
        TemplateEntry(title: "Diagonal", imageName: "Dg-01-01", objectCount: 1, guides:[
            ObjectGuide(x: 125, y: 417, width: 910),
        ]),
        TemplateEntry(title: "Diagonal", imageName: "Dg-01-02", objectCount: 2, guides:[
            ObjectGuide(x: 485, y: 187, width: 520),
            ObjectGuide(x: 225, y: 842, width: 520)
        ]),
        TemplateEntry(title: "Diagonal", imageName: "Dg-01-03", objectCount: 3, guides:[
            ObjectGuide(x: 444, y: -2, width: 615),
            ObjectGuide(x: 553, y: 700, width: 403),
            ObjectGuide(x: 261, y: 1040, width: 493)
        ]),
        
        // --- RULE OF THIRDS (RoT) ---
        TemplateEntry(title: "Rule of Thirds", imageName: "RoT-01-01", objectCount: 1, guides:[
            ObjectGuide(x: 471, y: 72, width: 635),
        ]),
        TemplateEntry(title: "Rule of Thirds", imageName: "RoT-01-02", objectCount: 2, guides:[
            ObjectGuide(x: 73, y: 41, width: 790),
            ObjectGuide(x: 385, y: 794, width: 790)
        ]),
        TemplateEntry(title: "Rule of Thirds", imageName: "RoT-01-03", objectCount: 3, guides:[
            ObjectGuide(x: 628, y: 245, width: 513),
            ObjectGuide(x: 47, y: 441, width: 513),
            ObjectGuide(x: 432, y: 891, width: 543)
        ]),
        
        // --- S-CURVE (SC) ---
        TemplateEntry(title: "S-Curve", imageName: "SC-01-01", objectCount: 1, guides:[
            ObjectGuide(x: 271, y: 577, width: 737)
        ]),
        TemplateEntry(title: "S-Curve", imageName: "SC-01-02", objectCount: 2, guides:[
            ObjectGuide(x: 369, y: 429, width: 630),
            ObjectGuide(x: -4, y: 1034, width: 630)
        ]),
        TemplateEntry(title: "S-Curve", imageName: "SC-01-03", objectCount: 3, guides:[
            ObjectGuide(x: 722, y: 319, width: 444),
            ObjectGuide(x: 231, y: 400, width: 444),
            ObjectGuide(x: 382, y: 864, width: 444)
        ]),
        
        // --- GOLDEN TRIANGLE (GT) ---
        TemplateEntry(title: "Golden Triangle", imageName: "GT-01-01", objectCount: 1, guides:[
            ObjectGuide(x: 196, y: 482, width: 231)
        ]),
        TemplateEntry(title: "Golden Triangle", imageName: "GT-01-02", objectCount: 2, guides:[
            ObjectGuide(x: -145, y: 154, width: 766),
            ObjectGuide(x: 397, y: 745, width: 748)
        ]),
        TemplateEntry(title: "Golden Triangle", imageName: "GT-01-03", objectCount: 3, guides:[
            ObjectGuide(x: -458, y: -57, width: 917),
            ObjectGuide(x: 515, y: 119, width: 424),
            ObjectGuide(x: 168, y: 618, width: 887)
        ])
    ]
}
