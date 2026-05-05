import SwiftUI

// MARK: - Reusable Template Card Component
struct TemplateCard: View {
    let entry: TemplateEntry
    
    var body: some View {
        VStack(spacing: 12) {
            Image(entry.imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
            
            Text(entry.title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding(10)
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
}

#Preview {
    NavigationStack {
        TemplateView(count: 2)
    }
}
