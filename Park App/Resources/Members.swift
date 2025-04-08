import Foundation

struct Member: Identifiable, Codable {
    var id = UUID()
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

struct DummyMembers {
    static let data: [Member] = [
        Member(nama: "Vanessa", nomorTelp: "08979661702", nomorPlat: "B 2213 ACW", jenisKendaraan: "mobil", namaKantor: "Apple Academy", nomorKantor: "08119871188", merk: "Toyota", tipeKendaraan: "Brio Satya E 2019", warna: "Merah"),
        Member(nama: "Rizky", nomorTelp: "081234567890", nomorPlat: "B 1234 XYZ", jenisKendaraan: "Motor", namaKantor: "Traveloka", nomorKantor: "081278945612", merk: "Honda", tipeKendaraan: "Vario 150", warna: "Hitam"),
        Member(nama: "Alya", nomorTelp: "081298765432", nomorPlat: "B 1387 DKC", jenisKendaraan: "Mobil", namaKantor: "SinarMas", nomorKantor: "081366554433", merk: "Honda", tipeKendaraan: "HR-V 2020", warna: "Putih"),
        Member(nama: "Dimas", nomorTelp: "081376543210", nomorPlat: "B 4321 GHI", jenisKendaraan: "Motor", namaKantor: "Purwadika", nomorKantor: "081334455667", merk: "Yamaha", tipeKendaraan: "NMax 2021", warna: "Biru"),
        Member(nama: "Siti", nomorTelp: "081212345678", nomorPlat: "B 9876 JKL", jenisKendaraan: "Mobil", namaKantor: "Apple Academy", nomorKantor: "0812345678", merk: "Suzuki", tipeKendaraan: "Ertiga 2022", warna: "Silver"),
        Member(nama: "Bayu", nomorTelp: "081278945612", nomorPlat: "B 3456 MNO", jenisKendaraan: "Mobil", namaKantor: "Traveloka", nomorKantor: "081278945612", merk: "Mitsubishi", tipeKendaraan: "Pajero Sport 2021", warna: "Hitam"),
        Member(nama: "Nina", nomorTelp: "081256789043", nomorPlat: "B 7890 PQR", jenisKendaraan: "Motor", namaKantor: "SinarMas", nomorKantor: "081366554433", merk: "Kawasaki", tipeKendaraan: "Ninja 250", warna: "Hijau"),
        Member(nama: "Andre", nomorTelp: "081334455667", nomorPlat: "B 1122 STU", jenisKendaraan: "Mobil", namaKantor: "Purwadika", nomorKantor: "081334455667", merk: "BMW", tipeKendaraan: "320i 2019", warna: "Putih"),
        Member(nama: "Citra", nomorTelp: "081390876543", nomorPlat: "B 2213 VWX", jenisKendaraan: "Motor", namaKantor: "Apple Academy", nomorKantor: "0812345678", merk: "Yamaha", tipeKendaraan: "Aerox 155", warna: "Merah"),
        Member(nama: "Kevin", nomorTelp: "081366554433", nomorPlat: "B 7788 YZA", jenisKendaraan: "Mobil", namaKantor: "Traveloka", nomorKantor: "081278945612", merk: "Mercedes-Benz", tipeKendaraan: "C200 2021", warna: "Abu-abu")
    ]
}
