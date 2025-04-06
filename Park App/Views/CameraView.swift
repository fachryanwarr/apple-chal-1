import SwiftUI
import AVFoundation
import Vision

struct CameraView: View {
    @State private var isFlashOn = false
    @State private var detectedText: String = ""
    
    var body: some View {
        VStack {
            Text("Scan Plat \n Nomor Kendaraan")
                .multilineTextAlignment(.center)
                .font(.title3)
                .bold()
            
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    CameraPreview(isFlashOn: isFlashOn, detectedText: $detectedText)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2))
                    
                    Button(action: {
                        isFlashOn.toggle()
                    }) {
                        Image(systemName: isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .padding(.bottom, 16)
                }
            }
            .padding(.horizontal, 10)
            
            Text("Sejajarkan plat nomor \n kendaraan dengan frame di atas")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .padding(.horizontal, 60)
                .padding(.top, 10)
            
            Text("Teks Terdeteksi: \(detectedText)")
                         .font(.subheadline)
                         .padding(.top, 10)
            
            Button(action: {
                print("Scan button pressed")
            }) {
                Text("SCAN")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
        }
    }
}


struct CameraPreview: UIViewControllerRepresentable {
    var isFlashOn: Bool
    @Binding var detectedText: String
    
    class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
        var captureSession: AVCaptureSession?
        var previewLayer: AVCaptureVideoPreviewLayer?
        var camera: AVCaptureDevice?
        var textRecognitionRequest = VNRecognizeTextRequest(completionHandler: nil)
        var detectedText: Binding<String>
        
        init(detectedText: Binding<String>) {
            self.detectedText = detectedText
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        override func viewDidLoad() {
            super.viewDidLoad()
            setupCamera()
            setupVision()
        }

        func setupCamera() {
            let session = AVCaptureSession()
            session.sessionPreset = .high

            guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
                  let input = try? AVCaptureDeviceInput(device: camera) else { return }
            
            session.addInput(input)

            let previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = view.bounds
            
            DispatchQueue.main.async {
                self.view.layer.addSublayer(previewLayer)
                self.previewLayer = previewLayer
            }

            let videoOutput = AVCaptureVideoDataOutput()
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            session.addOutput(videoOutput)

            DispatchQueue.global(qos: .userInitiated).async {
                session.startRunning()
            }

            self.captureSession = session
            self.camera = camera
        }

        func setupVision() {
            textRecognitionRequest = VNRecognizeTextRequest { (request, error) in
                guard let results = request.results as? [VNRecognizedTextObservation] else { return }
                let detectedTexts = results.compactMap { $0.topCandidates(1).first?.string }
                
                DispatchQueue.main.async {
                    self.detectedText.wrappedValue = detectedTexts.joined(separator: ", ")
                }
            }
            textRecognitionRequest.recognitionLevel = .accurate
        }

        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])

            do {
                try requestHandler.perform([textRecognitionRequest])
            } catch {
                print("Vision request failed: \(error)")
            }
        }

        func toggleFlash(isOn: Bool) {
            guard let camera = camera, camera.hasTorch else { return }
            do {
                try camera.lockForConfiguration()
                camera.torchMode = isOn ? .on : .off
                camera.unlockForConfiguration()
            } catch {
                print("Flash error: \(error)")
            }
        }
    }
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let controller = CameraViewController(detectedText: $detectedText)
        controller.toggleFlash(isOn: isFlashOn)
        return controller
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        uiViewController.toggleFlash(isOn: isFlashOn)
    }
}


#Preview {
    CameraView()
}
