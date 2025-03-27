import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack (spacing : 20)  {
            Spacer()
            
            Text("Temukan Member \nSecure Parking")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            
            Image(systemName: "qrcode.viewfinder")
                .resizable()
                .scaledToFit( )
                .frame(width: 150, height: 150)
                .foregroundColor(.blue)
                .padding(.vertical, 10)
            
            Text("Keamanan terbaik dimulai dengan langkah sederhana. Pindai, identifikasi, dan pastikan kendaraan terparkir sesuai dengan data.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
            Spacer()
            
            //tombol "scan plat nomor
            Button(action: {
                
            }) {
                Text("Scan Plat Nomor")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            
            //tombol "List Daftar Member"
            Button(action: {
                
            }) {
                Text("List Daftar Member")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
            }
            .padding(.horizontal, 40)
            
        }
        Spacer()
        
    }
}

#Preview {
    ContentView()
}
