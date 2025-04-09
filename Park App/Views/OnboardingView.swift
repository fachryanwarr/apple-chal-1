import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    private let hasSeenIntroPagesKey = "hasSeenIntroPages"

    private var hasSeenIntroPages: Bool {
        get { UserDefaults.standard.bool(forKey: hasSeenIntroPagesKey) }
        set { UserDefaults.standard.set(newValue, forKey: hasSeenIntroPagesKey) }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if hasSeenIntroPages {
                    OnboardingPage(image: DummyOnboarding.pages[2].image,
                                   title: DummyOnboarding.pages[2].title,
                                   description: DummyOnboarding.pages[2].description)
                } else {
                    TabView(selection: $currentPage) {
                        ForEach(Array(DummyOnboarding.pages.enumerated()), id: \.offset) { index, item in
                            OnboardingPage(image: item.image,
                                           title: item.title,
                                           description: item.description)
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(maxHeight: .infinity)
                    .ignoresSafeArea()
                    .animation(.easeInOut(duration: 0.5), value: currentPage)
                    .onChange(of: currentPage) { _, newValue in
                        if newValue == 2 {
                            UserDefaults.standard.set(true, forKey: hasSeenIntroPagesKey)
                        }
                    }
                }
                
                
                if hasSeenIntroPages || currentPage == 2 {
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
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = .dotActive
            UIPageControl.appearance().pageIndicatorTintColor = .dotRegular
        }
    }
}

#Preview {
    OnboardingView()
}
