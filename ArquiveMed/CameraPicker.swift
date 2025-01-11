import SwiftUI
import UIKit

struct CameraPicker: UIViewControllerRepresentable {
    @Binding var images: [UIImage]

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        // Optionally, set picker.cameraCaptureMode = .photo
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No dynamic updates needed
    }

    // MARK: - Coordinator
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraPicker

        init(_ parent: CameraPicker) {
            self.parent = parent
        }

        // Called when the user successfully captures a photo.
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            if let image = info[.originalImage] as? UIImage {
                // Append the new photo
                parent.images.append(image)
            }

            // Re-present the camera so the user can take another photo
            // without returning to SwiftUI yet.
            DispatchQueue.main.async {
                // First, dismiss the current picker (no animation or very quick).
                picker.dismiss(animated: false) {
                    // Create a new picker
                    let newPicker = UIImagePickerController()
                    newPicker.sourceType = .camera
                    newPicker.delegate = self
                    
                    // Present it from the rootViewController (hacky approach).
                    if let rootVC = UIApplication.shared.windows.first?.rootViewController {
                        rootVC.present(newPicker, animated: false, completion: nil)
                    } else {
                        print("Error: No rootVC found for presentation.")
                    }
                }
            }
        }

        // Called when user taps "Cancel".
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            // Dismiss and go back to SwiftUI
            picker.dismiss(animated: true)
        }
    }
}
