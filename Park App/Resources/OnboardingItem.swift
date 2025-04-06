import Foundation

struct OnboardingItem: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let description: String
}

struct DummyOnboarding {
    static let pages: [OnboardingItem] = [
        OnboardingItem(
            image: "onboarding-cop",
            title: "Selamat Datang",
            description: "Solusi cerdas untuk keamanan dan pengelolaan parkir yang lebih efisien🫡"
        ),
        OnboardingItem(
            image: "onboarding-phone",
            title: "Informasi Aplikasi",
            description: "Teknologi yang dirancang untuk membantu memindai plat nomor kendaraan🚗"
        ),
        OnboardingItem(
            image: "onboarding-plate",
            title: "Temukan Member Secure Parkir",
            description: "Gunakan fitur pemindaian untuk dapatkan akses daftar kendaraan yang terdaftar."
        )
    ]
}
