import Foundation
import UIKit

class MemberListViewModel: ObservableObject {
    
    func generateWhatsAppURL(to phoneNumber: String, message: String = "Hello!") -> String {
        var phone = phoneNumber
        if phone.hasPrefix("0") {
            phone = "62" + phone.dropFirst()
        }

        let encodedText = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? message

        return "https://wa.me/\(phone)?text=\(encodedText)"
    }

}
