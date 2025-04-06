import SwiftUI
import AVFoundation

struct CaptureView: View {
    @State private var flashOn = false
    @State private var useFrontCamera = false
    @State private var capturedImage: UIImage? = nil
    @State private var session = AVCaptureSession()
    @State private var output = AVCapturePhotoOutput()
    @State private var photoDelegate: PhotoCaptureDelegate? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Scan Plat \n Nomor Kendaraan")
                .multilineTextAlignment(.center)
                .font(.title2)
                .bold()
            
            ZStack(alignment: .bottom) {
                if let image = capturedImage {
                    // Tampilkan hasil capture
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 480)
                        .clipped()
                        .cornerRadius(16)
                } else {
                    // Kamera aktif
                    CapturePreview(session: $session)
                        .frame(width: 350, height: 480)
                        .background(Color.black)
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.8), lineWidth: 2))
                }
                
                if capturedImage == nil {
                    HStack {
                        // Switch Camera Button
                        Button(action: {
                            useFrontCamera.toggle()
                            configureSession()
                        }) {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.black.opacity(0.6))
                                .clipShape(Circle())
                        }
                        .disabled(flashOn)
                        .padding(.leading, 12)
                        
                        Spacer()
                        
                        // Flash Button
                        Button(action: {
                            flashOn.toggle()
                            toggleFlash()
                        }) {
                            Image(systemName: "bolt.fill")
                                .foregroundColor(.yellow)
                                .padding(10)
                                .background(Color.black.opacity(0.6))
                                .clipShape(Circle())
                        }
                        .disabled(useFrontCamera)
                        .padding(.trailing, 12)
                    }
                    .padding(.bottom, 12)
                    .frame(width: 350)
                }
            }
            
            if capturedImage == nil {
                Text("Sejajarkan plat nomor \n kendaraan dengan frame di atas")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .padding(.horizontal, 60)
                    .padding(.top, 5)
            }
            
            Button(action: {
                if capturedImage == nil {
                    print("Scan pressed")
                    takePhoto()
                } else {
                    // Reset
                    print("Rescan pressed")
                    capturedImage = nil
                }
            }) {
                Text(capturedImage == nil ? "SCAN" : "AMBIL ULANG")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(capturedImage == nil ? Color.blue : Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.white)
        .onAppear {
            configureSession()
        }
    }
    
    func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: .video),
              device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            device.torchMode = flashOn ? .on : .off
            device.unlockForConfiguration()
        } catch {
            print("Flash error: \(error)")
        }
    }
    
    func configureSession() {
        session.beginConfiguration()
        session.inputs.forEach { session.removeInput($0) }
        
        let position: AVCaptureDevice.Position = useFrontCamera ? .front : .back
        
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position),
              let input = try? AVCaptureDeviceInput(device: camera),
              session.canAddInput(input) else {
            return
        }
        
        session.addInput(input)
        
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        
        session.commitConfiguration()
        DispatchQueue.global(qos: .userInitiated).async {
            session.startRunning()
        }
    }
    
    func takePhoto() {
        let settings = AVCapturePhotoSettings()
        let delegate = PhotoCaptureDelegate { image in
            DispatchQueue.main.async {
                capturedImage = image
            }
        }
        self.photoDelegate = delegate // Tahan referensinya
        output.capturePhoto(with: settings, delegate: delegate)
    }
}

// MARK: - UIViewRepresentable Preview Layer
struct CapturePreview: UIViewRepresentable {
    @Binding var session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = CGRect(x: 0, y: 0, width: 350, height: 480)
        view.layer.addSublayer(previewLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

// MARK: - PhotoCapture Delegate
class PhotoCaptureDelegate: NSObject, AVCapturePhotoCaptureDelegate {
    private let onPhotoCaptured: (UIImage) -> Void
    
    init(onPhotoCaptured: @escaping (UIImage) -> Void) {
        self.onPhotoCaptured = onPhotoCaptured
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        if let data = photo.fileDataRepresentation(),
           let image = UIImage(data: data) {
            onPhotoCaptured(image)
        }
    }
}

#Preview {
    CaptureView()
}
