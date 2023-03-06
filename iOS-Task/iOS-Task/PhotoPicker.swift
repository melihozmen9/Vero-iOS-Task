//
//  PhotoPicker.swift
//  iOS-Task
//
//  Created by Kullanici on 28.02.2023.
//

import SwiftUI


struct PhotoPicker: UIViewControllerRepresentable{
   
  
    @Binding var searchText : String
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    final class Coordinator : NSObject, UINavigationControllerDelegate,UIImagePickerControllerDelegate{
        
        let photoPicker : PhotoPicker
        
        init(photoPicker:PhotoPicker){
            self.photoPicker = photoPicker
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                func scanQRCode(from image: UIImage) -> String? {
                    guard let ciImage = CIImage(image: image) else {
                        return nil
                    }
                    
                    let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [
                        CIDetectorAccuracy: CIDetectorAccuracyHigh
                    ])
                    
                    let features = detector?.features(in: ciImage)
                    
                    if let firstFeature = features?.first as? CIQRCodeFeature {
                        return firstFeature.messageString
                    }
                    
                    return nil
                }
                if let qrCodeString = scanQRCode(from: image) {
                      print("QR code string: \(qrCodeString)")
                    photoPicker.searchText = qrCodeString
                  } else {
                      print("No QR code found")
                  }
                
            }else {
                print("Error choosing the file")
            }
            picker.dismiss(animated: true)
        }
    }
    }

  
    

