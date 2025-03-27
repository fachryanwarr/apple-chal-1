//
//  MemberListView.swift
//  Park App
//
//  Created by Valencia Sutanto on 25/03/25.
//
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
                    
                    GridRow{
                        Text("No. Telp")
                        Text(":")
                        Text(nomorTelp)
                    }
                }.padding()
                    .frame(width: 330, height: 80)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color.black, lineWidth: 1)
//                    )
                
                HStack{
                    Spacer()
                    Text(nomorPlat)
                        .font(.headline)
                        .fontWeight(.bold)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.leading, 10)
        
                    Spacer()
                    if(jenisKendaraan.caseInsensitiveCompare("mobil") == .orderedSame){
                        Image(systemName: "car")
                    }else{
                        Image(systemName: "motorcycle")
                    }
                    
                }
                
            }
            .padding(10)
            .frame(width: 350, height: 130)
            .background(Color.blue.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .overlay(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color.black)
//            )
        }
    }

#Preview{
    MemberCard(nama: "Vanessa", nomorTelp: "081118929083", nomorPlat: "B 2213 ACW", jenisKendaraan: "mobil")
}
