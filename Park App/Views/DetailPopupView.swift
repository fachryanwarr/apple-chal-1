import SwiftUI

struct DetailPopupView: View {
    @StateObject private var memberViewModel = MemberListViewModel()
    let member: Member
    
    var body: some View {
            VStack(alignment: .leading) {
                NavigationLink(destination: MemberDetail(member: member)){
                    VStack(alignment: .leading){
                        HStack(spacing: 20) {
                            Image(systemName: member.jenisKendaraan == "motor" ? "motorcycle.fill" : "car.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
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
                    }
                }
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
                        if let url = URL(string: memberViewModel.generateWhatsAppURL(to: member.nomorTelp)) {
                                UIApplication.shared.open(url)
                            }
                    } label: {
                        Image(systemName: "ellipsis.message.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                            .padding(10)
                            .background(Color.white.opacity(0.4))
                            .clipShape(Circle())
                            .frame(width: 28, height: 28)
                    }
                }
                .padding(.top, 10)
                
            }
            .foregroundStyle(Color.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 30)
            .frame(maxWidth: .infinity)
            .background(Color.popupBg)
            .cornerRadius(24)
        }
//        .buttonStyle(PlainButtonStyle())
        
//    }
}

#Preview{
    DetailPopupView(member: Member(nama: "Vanessa", nomorTelp: "081118929083", nomorPlat: "B 2213 ACW", jenisKendaraan: "mobil", namaKantor: "Apple Academy", nomorKantor: "0812345678", merk: "Toyota", tipeKendaraan: "Brio Satya E 2019", warna: "Merah"))
}
