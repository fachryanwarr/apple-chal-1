import SwiftUI

struct MemberDetail: View {
    let member: Member
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                if member.jenisKendaraan.lowercased() == "mobil" {
                    Image(systemName: "car.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                } else {
                    Image(systemName: "motorcycle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                }
                
                Text(member.nomorPlat)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            
            // Information Fields
            VStack(spacing: 10) {
                DetailRow(title: "Nama Pemilik Kendaraan", value: member.nama)
                DetailRow(title: "Nomor Telepon", value: member.nomorTelp, isPhone: true)
                DetailRow(title: "Nama Kantor", value: member.namaKantor)
                DetailRow(title: "Nomor Telepon Kantor", value: member.nomorKantor, isPhone: true)
                DetailRow(title: "Merk", value: "Honda")
                DetailRow(title: "Tipe Kendaraan", value: member.tipeKendaraan)
                DetailRow(title: "Warna Kendaraan", value: member.warna)
            }
            .padding(.horizontal)
            
            Spacer()
            
        }
        .padding(.horizontal)
        
        
    }
    
}

struct DetailRow: View {
    var title: String
    var value: String
    var isPhone: Bool = false
    
    func openWhatsApp() {
        var phone = value
        let text = "Hello!"
        
        if phone.hasPrefix("0") {
            phone = "62" + phone.dropFirst()
        }
        
        let urlStr = "https://wa.me/\(phone)?text=\(text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"
        
        if let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
            
            HStack {
                Text(value)
                    .foregroundColor(.gray)
                    .fontWeight(.medium)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.gray.opacity(0.17))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4))
                    )
                
                if isPhone {
                    Button(action: {
                        openWhatsApp()
                    }){
                        Image(systemName: "ellipsis.message.fill")
                            .foregroundColor(.white)
                            .padding(16)
                            .background(.blue)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .navigationTitle("Detail Member")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview{
    MemberDetail(member: Member(nama: "Vanessa", nomorTelp: "081118929083", nomorPlat: "B 2213 ACW", jenisKendaraan: "mobil", namaKantor: "Apple Academy", nomorKantor: "0812345678", merk: "Toyota", tipeKendaraan: "Brio Satya E 2019", warna: "Merah"))
}
