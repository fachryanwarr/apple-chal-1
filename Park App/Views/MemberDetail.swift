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
                DetailRow(title: "Nomor Telepon Kantor", value: member.nomorKantor)
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

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.footnote)
                .foregroundColor(.black)
                .fontWeight(.semibold)

            HStack {
                Text(value)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue)
                    )

                if isPhone {
                    Button(action: {
                        // Call action
                    }) {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.blue)
                            .padding(16)
//                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue)
                            )
                    }
                }
            }
        }
        .navigationTitle("Detail Member")
        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .principal) {
//                Text("Detail Member")
//                    .font(.system(size: 30, weight: .bold))
//                    .foregroundColor(.black)
//                    .padding(.top, 15)
//            }
//        }
    }
}

#Preview{
    MemberDetail(member: Member(nama: "Vanessa", nomorTelp: "081118929083", nomorPlat: "B 2213 ACW", jenisKendaraan: "mobil", namaKantor: "Apple Academy", nomorKantor: "0812345678", merk: "Toyota", tipeKendaraan: "Brio Satya E 2019", warna: "Merah"))
}
