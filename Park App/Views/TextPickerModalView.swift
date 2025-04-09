import SwiftUI

struct TextPickerModalView: View {
    @Binding var show: Bool
    @Binding var selectedText: String
    var identifiedTexts: [String]
    
    var body: some View {
        ZStack {
            Color.overlay
                .ignoresSafeArea()
                .onTapGesture {
                    show = false
                }
            
            VStack(spacing: 20) {
                Text("Choose detected text")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.modalHeader)
                
                VStack(spacing: 20) {
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
                    .background(Color.modal)
                    .cornerRadius(12)
                    
                    Button {
                        show = false
                    } label: {
                        Text("Choose")
                            .fontWeight(.semibold)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 6)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
            }
            .padding(.bottom)
            .background(Color.modal)
            .cornerRadius(20)
            .padding(.horizontal, 30)
            .shadow(radius: 20)
        }
    }
}
