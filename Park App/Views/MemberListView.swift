import SwiftUI

struct MemberListView: View {
    
    @State private var selectedMember: Member? = nil
    @State private var isShowingDetail = false
    
    @State private var searchText = ""
    
    let members = DummyMembers.data
    
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
