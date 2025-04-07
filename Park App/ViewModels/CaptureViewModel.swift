import SwiftUI
import AVFoundation
import Vision

class CaptureViewModel: ObservableObject {
    @Published var flashOn = false
    @Published var useFrontCamera = false
    @Published var capturedImage: UIImage? = nil
    @Published var session = AVCaptureSession()
    @Published var identifiedTexts: [String] = []
    @Published var selectedText: String = ""
    @Published var showTextPicker: Bool = false
    
    private let output = AVCapturePhotoOutput()
    private var photoDelegate: PhotoCaptureDelegate? = nil
    
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
            self.session.startRunning()
        }
    }
    
    func takePhoto() {
        let settings = AVCapturePhotoSettings()
        let delegate = PhotoCaptureDelegate { image in
            DispatchQueue.main.async {
                self.capturedImage = image
                self.recognizeText(from: image)
            }
        }
        self.photoDelegate = delegate
        output.capturePhoto(with: settings, delegate: delegate)
    }
    
    func recognizeText(from image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            let texts = observations
                .compactMap { $0.topCandidates(1).first?.string }
                .filter { $0.count >= 7 && $0.count <= 12 }
            DispatchQueue.main.async {
                self?.identifiedTexts = texts
            }
        }
        
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Text recognition error: \(error)")
            }
        }
    }
}
