import SwiftUI

struct DetailPopupView: View {
    let member: Member
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                Image(systemName: "motorcycle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(10)
                    .background(Color.orange)
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
                
                VStack(alignment: .leading) {
                    Text(member.nomorPlat)
                        .font(.title2)
                        .bold()
                    Text(member.tipeKendaraan)
                        .foregroundStyle(Color.white)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack() {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Nama Pemilik")
                        .bold()
                    Text(member.nama)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Kantor")
                        .bold()
                    Text(member.namaKantor)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, 10)

            VStack(alignment: .leading, spacing: 4) {
                Text("Kontak Kantor")
                    .bold()
                Text(member.nomorKantor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 12)
            
            
            Divider()
                .frame(height: 1)
                .background(Color.white)
                .padding(.top, 10)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Kontak Pemilik")
                        .bold()
                    Text(member.nomorTelp)
                        .font(.title2)
                        .bold()
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Call")
                }
            }
            .padding(.top, 10)
            
        }
        .foregroundStyle(Color.white)
        .padding(.horizontal)
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(24)
    }
}

#Preview{
    DetailPopupView(member: Member(nama: "Vanessa", nomorTelp: "081118929083", nomorPlat: "B 2213 ACW", jenisKendaraan: "mobil", namaKantor: "Apple Academy", nomorKantor: "0812345678", merk: "Toyota", tipeKendaraan: "Brio Satya E 2019", warna: "Merah"))
}
