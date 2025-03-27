//
//  MemberSearchView.swift
//  Park App
//
//  Created by Valencia Sutanto on 25/03/25.
//

import SwiftUI

struct MemberListView: View {
    
    @State private var selectedMember: Member? = nil
    @State private var isShowingDetail = false
    
    @State private var searchText = ""
    
    let members = [
        Member(nama: "Vanessa", nomorTelp: "081118929083", nomorPlat: "B 2213 ACW", jenisKendaraan: "mobil", namaKantor: "Apple Academy", nomorKantor: "0812345678", merk: "Toyota", tipeKendaraan: "Brio Satya E 2019", warna: "Merah"),
            Member(nama: "Rizky", nomorTelp: "081234567890", nomorPlat: "B 1234 XYZ", jenisKendaraan: "Motor", namaKantor: "Traveloka", nomorKantor: "081278945612", merk: "Honda", tipeKendaraan: "Vario 150", warna: "Hitam"),
            Member(nama: "Alya", nomorTelp: "081298765432", nomorPlat: "B 6789 DEF", jenisKendaraan: "Mobil", namaKantor: "SinarMas", nomorKantor: "081366554433", merk: "Honda", tipeKendaraan: "HR-V 2020", warna: "Putih"),
            Member(nama: "Dimas", nomorTelp: "081376543210", nomorPlat: "B 4321 GHI", jenisKendaraan: "Motor", namaKantor: "Purwadika", nomorKantor: "081334455667", merk: "Yamaha", tipeKendaraan: "NMax 2021", warna: "Biru"),
            Member(nama: "Siti", nomorTelp: "081212345678", nomorPlat: "B 9876 JKL", jenisKendaraan: "Mobil", namaKantor: "Apple Academy", nomorKantor: "0812345678", merk: "Suzuki", tipeKendaraan: "Ertiga 2022", warna: "Silver"),
            Member(nama: "Bayu", nomorTelp: "081278945612", nomorPlat: "B 3456 MNO", jenisKendaraan: "Mobil", namaKantor: "Traveloka", nomorKantor: "081278945612", merk: "Mitsubishi", tipeKendaraan: "Pajero Sport 2021", warna: "Hitam"),
            Member(nama: "Nina", nomorTelp: "081256789043", nomorPlat: "B 7890 PQR", jenisKendaraan: "Motor", namaKantor: "SinarMas", nomorKantor: "081366554433", merk: "Kawasaki", tipeKendaraan: "Ninja 250", warna: "Hijau"),
            Member(nama: "Andre", nomorTelp: "081334455667", nomorPlat: "B 1122 STU", jenisKendaraan: "Mobil", namaKantor: "Purwadika", nomorKantor: "081334455667", merk: "BMW", tipeKendaraan: "320i 2019", warna: "Putih"),
            Member(nama: "Citra", nomorTelp: "081390876543", nomorPlat: "B 5566 VWX", jenisKendaraan: "Motor", namaKantor: "Apple Academy", nomorKantor: "0812345678", merk: "Yamaha", tipeKendaraan: "Aerox 155", warna: "Merah"),
            Member(nama: "Kevin", nomorTelp: "081366554433", nomorPlat: "B 7788 YZA", jenisKendaraan: "Mobil", namaKantor: "Traveloka", nomorKantor: "081278945612", merk: "Mercedes-Benz", tipeKendaraan: "C200 2021", warna: "Abu-abu")
        ]
    
    var filteredMembers: [Member]{
        if searchText.isEmpty{
            return members
        }else{
            return members.filter{$0.nomorPlat.localizedCaseInsensitiveContains(searchText)}
            
        }
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                if(filteredMembers.isEmpty){
                    VStack {
                        Spacer()
                        
                        VStack {
                            Image("NotFound")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            Text("Kendaraan dengan nomor plat ini belum terdaftar")
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .frame(width: 300, height: 200)
                        .background(Color.blue.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.7)
                    
                } else{
                    
                    ForEach(filteredMembers) {member in NavigationLink(destination: MemberDetail(member: member)){
                        MemberCard(nama: member.nama, nomorTelp: member.nomorTelp, nomorPlat: member.nomorPlat, jenisKendaraan: member.jenisKendaraan)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 10)
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.white)
                }
                    
            }.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Cari member berdasarkan nomor plat")
                .tint(.blue)
                .navigationTitle("Daftar Member")
                .navigationBarTitleDisplayMode(.large)

        }
        
    }
       
}

#Preview {
    MemberListView()
}

struct Member: Identifiable {
    let id = UUID()
    let nama: String
    let nomorTelp: String
    let nomorPlat: String
    let jenisKendaraan: String
    let namaKantor: String
    let nomorKantor: String
    let merk: String
    let tipeKendaraan: String
    let warna: String
}
