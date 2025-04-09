import Foundation
import UIKit

class MemberListViewModel: ObservableObject {
    @Published var searchText: String = ""
    private let members = DummyMembers.data
    
    var filteredMembers: [Member] {
        if searchText.isEmpty {
            return members
        } else {
            return members.filter { $0.nomorPlat.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func generateWhatsAppURL(to phoneNumber: String, message: String = "Hello!") -> String {
        var phone = phoneNumber
        if phone.hasPrefix("0") {
            phone = "62" + phone.dropFirst()
        }
        
        let encodedText = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? message
        
        return "https://wa.me/\(phone)?text=\(encodedText)"
    }
    
}
