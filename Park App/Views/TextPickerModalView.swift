import SwiftUI

struct TextPickerModalView: View {
    @Binding var show: Bool
    @Binding var selectedText: String
    var identifiedTexts: [String]
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    show = false
                }
            
            VStack(spacing: 20) {
                Text("Choose detected text")
                    .font(.headline)
                
                Picker(selection: $selectedText) {
                    Text("Choose one...").tag("")
                    ForEach(identifiedTexts, id: \.self) { text in
                        Text(text).tag(text)
                    }
                } label: {
                    Text("")
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .clipped()
                .background(Color.white)
                .cornerRadius(12)
                
                Button {
                    show = false
                } label: {
                    Text("Choose")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal, 30)
            .shadow(radius: 20)
        }
    }
}
