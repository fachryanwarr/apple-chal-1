import SwiftUI
import AVFoundation

struct CaptureView: View {
    @StateObject private var viewModel = CaptureViewModel()
    @State private var showMemberModal = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Scan Plat \n Nomor Kendaraan")
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .bold()
                
                ZStack(alignment: .bottom) {
                    if let image = viewModel.capturedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 350, height: 440)
                            .clipped()
                            .cornerRadius(16)
                            .padding(.horizontal)
                    } else {
                        CapturePreview(session: $viewModel.session)
                            .frame(width: 350, height: 440)
                            .background(Color.black)
                            .cornerRadius(16)
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.8), lineWidth: 2))
                    }
                    
                    if viewModel.capturedImage == nil {
                        HStack {
                            Button(action: {
                                viewModel.useFrontCamera.toggle()
                                viewModel.configureSession()
                            }) {
                                Image(systemName: "arrow.triangle.2.circlepath.camera")
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.black.opacity(0.6))
                                    .clipShape(Circle())
                            }
                            .disabled(viewModel.flashOn)
                            .padding(.leading, 12)
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.flashOn.toggle()
                                viewModel.toggleFlash()
                            }) {
                                Image(systemName: "bolt.fill")
                                    .foregroundColor(.yellow)
                                    .padding(10)
                                    .background(Color.black.opacity(0.6))
                                    .clipShape(Circle())
                            }
                            .disabled(viewModel.useFrontCamera)
                            .padding(.trailing, 12)
                        }
                        .padding(.bottom, 12)
                        .frame(width: 350)
                    }
                }
                
                VStack(spacing: 14) {
                    if viewModel.capturedImage == nil {
                        Text("Sejajarkan plat nomor \n kendaraan dengan frame di atas")
                            .multilineTextAlignment(.center)
                            .font(.subheadline)
                            .padding(.horizontal, 60)
                            .padding(.top, 5)
                    }
                    
                    if let _ = viewModel.capturedImage {
                        if !viewModel.identifiedTexts.isEmpty {
                            HStack {
                                Button(action: {
                                    viewModel.showTextPicker = true
                                }) {
                                    Text(viewModel.selectedText.isEmpty ? "Choose detected text" : viewModel.selectedText)
                                        .frame(maxWidth: .infinity, maxHeight: 40)
                                }
                                .buttonStyle(.borderedProminent)
                                
                                Button {
                                    showMemberModal = true
                                } label: {
                                    Image(systemName: "arrowshape.right.fill")
                                        .resizable()
                                        .frame(maxWidth: 16, maxHeight: 16)
                                        .aspectRatio(1, contentMode: .fit)
                                        .frame(maxWidth: 40, maxHeight: 40)
                                }
                                .frame(maxWidth: 50, maxHeight: 50)
                                .cornerRadius(8)
                                .disabled(viewModel.selectedText == "")
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.horizontal, 20)
                        } else {
                            HStack {
                                Image(systemName: "info.circle")
                                Text("No identified text found")
                                    .italic()
                            }
                            .foregroundStyle(.red)
                        }
                    }
                    
                    
                    Button(action: {
                        if viewModel.capturedImage == nil {
                            viewModel.takePhoto()
                        } else {
                            viewModel.selectedText = ""
                            viewModel.capturedImage = nil
                        }
                    }) {
                        Text(viewModel.capturedImage == nil ? "CAPTURE" : "CAPTURE ULANG")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(viewModel.capturedImage == nil ? Color.blue : Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .onAppear {
                viewModel.configureSession()
            }
            
            if viewModel.showTextPicker {
                TextPickerModalView(
                    show: $viewModel.showTextPicker,
                    selectedText: $viewModel.selectedText,
                    identifiedTexts: viewModel.identifiedTexts
                )
            }
            
            let filteredMembers = DummyMembers.data.filter {
                $0.nomorPlat.lowercased().contains(viewModel.selectedText.lowercased())
            }
            
            if showMemberModal {
                ZStack {
                    Color.overlay
                        .ignoresSafeArea()
                        .onTapGesture {
                            showMemberModal = false
                        }
                    
                    VStack {
                        HStack {
                            Spacer()
                            
                            Button {
                                showMemberModal = false
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .foregroundStyle(.white.opacity(0.7))
                                    .scaledToFit()
                                    .frame(width: 28, height: 28)
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer()
                    }
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            if (!filteredMembers.isEmpty) {
                                ForEach(filteredMembers) { member in
                                    DetailPopupView(member: member)
                                }
                            } else {
                                NotFoundView()
                            }
                        }
                        .padding(.vertical)
                    }
                    .scrollIndicators(.hidden)
                    .padding(.horizontal, 55)
                }
            }
        }
    }
}

#Preview {
    CaptureView()
}
