//
//  TemplateCard.swift
//  Mise
//
//  Created by M Ilmi Nasrulloh on 02/05/26.
//

import SwiftUI

struct TemplateCard: View {
    let entry: TemplateEntry
    
    var body: some View {
        ZStack(alignment: .bottom) {
                Image(entry.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width : 169, height: 225)
                .clipped()
            
            HStack{
                Text(entry.title)
                    .font(.body)
                Spacer()
                Image(systemName: "info.circle")
            }
            .foregroundColor(.white)
            .shadow(radius: 10)
            .padding(12)
            .frame(width: 169, height: 54, alignment: .leading)
            .glassEffect(.clear, in: .rect())
            .shadow(radius: 10)
        }
        .cornerRadius(15)

        
        
        
    }
}


#Preview {
    TemplateCard(entry: TemplateEntry(
        title: "Rule of Thrids",
        imageName: "image1",
    ))
}
