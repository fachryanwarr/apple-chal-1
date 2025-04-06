import SwiftUI
import AVFoundation

struct CaptureView: View {
    @StateObject private var viewModel = CaptureViewModel()

    var body: some View {
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
                        .frame(width: 350, height: 480)
                        .clipped()
                        .cornerRadius(16)
                } else {
                    CapturePreview(session: $viewModel.session)
                        .frame(width: 350, height: 480)
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

            if viewModel.capturedImage == nil {
                Text("Sejajarkan plat nomor \n kendaraan dengan frame di atas")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .padding(.horizontal, 60)
                    .padding(.top, 5)
            }

            Button(action: {
                if viewModel.capturedImage == nil {
                    viewModel.takePhoto()
                } else {
                    viewModel.capturedImage = nil
                }
            }) {
                Text(viewModel.capturedImage == nil ? "SCAN" : "AMBIL ULANG")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(viewModel.capturedImage == nil ? Color.blue : Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)

            Spacer()
        }
        .padding(.horizontal)
        .background(Color.white)
        .onAppear {
            viewModel.configureSession()
        }
    }
}

#Preview {
    CaptureView()
}
