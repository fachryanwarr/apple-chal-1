import SwiftUI

struct OnboardingPage: View {
    var image: String
    var title: String
    var description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .cornerRadius(20)
                .padding()
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
