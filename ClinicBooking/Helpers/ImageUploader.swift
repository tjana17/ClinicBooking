//
//  ImageUploader.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 18/09/24.
//

import Foundation
import SwiftUI
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")

        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Err: Failed to upload image \(error.localizedDescription)")
                return
            }

            ref.downloadURL { url, error in
                guard let imageURL = url?.absoluteString else {return}
                completion(imageURL)
            }
        }
    }
}
