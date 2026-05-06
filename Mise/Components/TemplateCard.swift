import SwiftUI

// MARK: - Reusable Template Card Component
struct TemplateCard: View {
    let entry: TemplateEntry
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ZStack(alignment: .bottom) {
                
                Image(entry.imageName)
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .aspectRatio(contentMode: .fit)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
                
                HStack {
                    Spacer()
                    
                    Text(entry.title)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
//                    Image(systemName: "info.circle")
//                        .font(.headline)
//                        .foregroundColor(.white)
                    
                }
                .shadow(radius: 10)
                .padding(10)
                .glassEffect(.clear, in: .rect())
                    
            }
            .cornerRadius(16)
        }
    }
}

#Preview {
    TemplateCard(entry: TemplateEntry(
        title: "Diagonal",
        imageName: "Dg-01-03",
        objectCount: 3, guides:[
        ObjectGuide(x: 444, y: -2, width: 615),
        ObjectGuide(x: 553, y: 700, width: 403),
        ObjectGuide(x: 261, y: 1040, width: 493)
    ]))
}
