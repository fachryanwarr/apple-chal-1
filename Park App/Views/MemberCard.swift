import SwiftUI

struct MemberCard: View{
    var nama: String
    var nomorTelp: String
    var nomorPlat: String
    var jenisKendaraan: String
    
    var body: some View{
            VStack(alignment: .leading){
                Grid(alignment: .leading){
                    GridRow{
                        Text("Nama")
                        Text(":")
                        Text(nama)
                        Spacer()
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    
                    GridRow{
                        Text("No. Telp")
                        Text(":")
                        Text(nomorTelp)

                    }
                    .font(.headline)
                    .foregroundColor(.black)

                }.padding()
                    .frame(width: 330, height: 80)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack{
                    Spacer()
                    Text(nomorPlat)
                        .font(.title3)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.leading, 10)
        
                    Spacer()
                    if(jenisKendaraan.caseInsensitiveCompare("mobil") == .orderedSame){
                        Image(systemName: "car.fill")
                            .foregroundColor(.white)
                    }else{
                        Image(systemName: "motorcycle.fill")
                            .foregroundColor(.white)
                    }
                    
                }
                
            }
            .padding(10)
            .frame(width: 350, height: 130)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        
        }
    }

#Preview{
    MemberCard(nama: "Vanessa", nomorTelp: "081118929083", nomorPlat: "B 2213 ACW", jenisKendaraan: "mobil")
}
