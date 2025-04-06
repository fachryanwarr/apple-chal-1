import SwiftUI

struct MemberListView: View {
    
    @State private var searchText = ""
    let members = [
        Member(nama: "Vanessa", nomorTelp: "081118929083", nomorPlat: "B 2213 ACW", tipeKendaraan: "mobil"),
        Member(nama: "Rizky", nomorTelp: "081234567890", nomorPlat: "B 1234 XYZ", tipeKendaraan: "Motor"),
        Member(nama: "Alya", nomorTelp: "081298765432", nomorPlat: "B 6789 DEF", tipeKendaraan: "Mobil"),
        Member(nama: "Dimas", nomorTelp: "081376543210", nomorPlat: "B 4321 GHI", tipeKendaraan: "Motor"),
        Member(nama: "Siti", nomorTelp: "081212345678", nomorPlat: "B 9876 JKL", tipeKendaraan: "Mobil"),
        Member(nama: "Bayu", nomorTelp: "081278945612", nomorPlat: "B 3456 MNO", tipeKendaraan: "Mobil"),
        Member(nama: "Nina", nomorTelp: "081256789043", nomorPlat: "B 7890 PQR", tipeKendaraan: "Motor"),
        Member(nama: "Andre", nomorTelp: "081334455667", nomorPlat: "B 1122 STU", tipeKendaraan: "Mobil"),
        Member(nama: "Citra", nomorTelp: "081390876543", nomorPlat: "B 5566 VWX", tipeKendaraan: "Motor"),
        Member(nama: "Kevin", nomorTelp: "081366554433", nomorPlat: "B 7788 YZA", tipeKendaraan: "Mobil")
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
            VStack{
                List(filteredMembers) {member in
                    MemberCard(nama: member.nama, nomorTelp: member.nomorTelp, nomorPlat: member.nomorPlat, tipeKendaraan: member.tipeKendaraan)
                }
                .scrollContentBackground(.hidden)
                .background(Color.white)
            }.searchable(text: $searchText, prompt: "Cari member berdasarkan nomor plat")
                .navigationTitle("Daftar Member")
                .tint(.blue)
//                .onAppear {
//                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.white.withAlphaComponent(0.2)
//                }
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
    let tipeKendaraan: String
}
