import UIKit
import AVFoundation

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
