import SwiftUI

struct MemberListView: View {
    @StateObject private var viewModel = MemberListViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView {
                if (viewModel.filteredMembers.isEmpty) {
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
                    
                } else {
                    ForEach(viewModel.filteredMembers) { member in NavigationLink(destination: MemberDetail(member: member)){
                        MemberCard(nama: member.nama, nomorTelp: member.nomorTelp, nomorPlat: member.nomorPlat, jenisKendaraan: member.jenisKendaraan)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 10)
                    }
                    .scrollContentBackground(.hidden)
                }
            }.searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Cari member berdasarkan nomor plat")
                .tint(.blue)
                .navigationTitle("Daftar Member")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    MemberListView()
}
