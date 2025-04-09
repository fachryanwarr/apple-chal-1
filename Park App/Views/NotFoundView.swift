import SwiftUI

struct NotFoundView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Image(.notFound)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("Data not found")
                .font(.title)
                .bold()
            
        }
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
        .background(.modal)
        .cornerRadius(24)
    }
}

#Preview{
    NotFoundView()
}
