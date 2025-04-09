import SwiftUI

struct MemberDetail: View {
    let member: Member
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                Image(systemName: member.jenisKendaraan.lowercased() == "mobil" ? "car.fill" : "motorcycle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                
                Text(member.nomorPlat)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            
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
    @StateObject private var memberViewModel = MemberListViewModel()
    var title: String
    var value: String
    var isPhone: Bool = false
    
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
                    Button {
                        if let url = URL(string: memberViewModel.generateWhatsAppURL(to: value)) {
                                UIApplication.shared.open(url)
                            }
                    } label: {
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
