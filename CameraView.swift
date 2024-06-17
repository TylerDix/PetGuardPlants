import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate {
        var parent: CameraView
        var session: AVCaptureSession!
        var output: AVCapturePhotoOutput!

        init(parent: CameraView) {
            self.parent = parent
            super.init()
            configureSession()
        }
        // small change

        func configureSession() {
            session = AVCaptureSession()
            session.beginConfiguration()

            let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            let videoDeviceInput = try! AVCaptureDeviceInput(device: videoDevice!)

            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
            }

            output = AVCapturePhotoOutput()
            if session.canAddOutput(output) {
                session.addOutput(output)
            }

            session.commitConfiguration()
        }

        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            guard let imageData = photo.fileDataRepresentation() else { return }
            let uiImage = UIImage(data: imageData)

            // Handle the captured image
        }

        @objc func takePhoto() {
            let settings = AVCapturePhotoSettings()
            output.capturePhoto(with: settings, delegate: self)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        context.coordinator.session.startRunning()
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
