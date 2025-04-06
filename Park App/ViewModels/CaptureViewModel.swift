import SwiftUI
import AVFoundation

class CaptureViewModel: ObservableObject {
    @Published var flashOn = false
    @Published var useFrontCamera = false
    @Published var capturedImage: UIImage? = nil
    @Published var session = AVCaptureSession()

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
            }
        }
        self.photoDelegate = delegate
        output.capturePhoto(with: settings, delegate: delegate)
    }
}
