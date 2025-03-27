import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                OnboardingPage(image: "halaman1", title: "Selamat Datang", description: "Solusi cerdas untuk keamanan dan pengelolaan parkir yang lebih efisien🫡")
                    .tag(0)
                OnboardingPage(image: "Frame 4", title: "Informasi Aplikasi", description: "Teknologi yang dirancang untuk membantu memindai plat nomor kendaraan🚗")
                    .tag(1)
                OnboardingPage(image: "halaman3", title: "Temukan Member Secure Parkir", description: "Gunakan fitur pemindaian untuk dapatkan akses daftar kendaraan yang terdaftar.")
                    .tag(2)
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
            .padding(.bottom, 20)
            
            if currentPage == 2 {
                            VStack(spacing: 10) {
                                Button(action: {
                                    print("Get Started Tapped")
                                }) {
                                    Text("Scan Plat Nomor")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, minHeight: 60) // Lebih ramping
                                        .background(Color.blue)
                                        .cornerRadius(12)
                                }
                                .padding(.horizontal)
                                
                                Button(action: {
                                    print("List Daftar Member Tapped")
                                }) {
                                    Text("List Daftar Member")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, minHeight: 44) // Lebih ramping
                                        .background(Color.white)
                                        .cornerRadius(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                }
                                .padding(.horizontal)
                            }
                            
                        }
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
}
