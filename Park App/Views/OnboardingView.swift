import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(Array(DummyOnboarding.pages.enumerated()), id: \.offset) { index, item in
                        OnboardingPage(image: item.image, title: item.title, description: item.description)
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(maxHeight: .infinity)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.5), value: currentPage)
                
                // Custom Page Indicators
                HStack(spacing: 8) {
                    ForEach(0..<3) { index in
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(currentPage == index ? .blue : .gray.opacity(0.5))
                            .scaleEffect(currentPage == index ? 1.2 : 1)
                            .animation(.spring(), value: currentPage)
                    }
                }
                
                if currentPage == 2 {
                    VStack(spacing: 10) {
                        NavigationLink(destination: CaptureView()) {
                            Text("Scan Plat Nomor")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        
                        NavigationLink(destination: MemberListView()) {
                            Text("List Daftar Member")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, minHeight: 44)
                                .background(Color.white)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                        }
                    }
                    .padding(.top, 10)
                    .padding(.horizontal)
                }
            }
        }
        .padding()
    }
}

#Preview {
    NavigationStack{
        OnboardingView()
    }
}
