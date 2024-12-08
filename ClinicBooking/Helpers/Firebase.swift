//
//  Firebase.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 12/09/24.
//

import Foundation
import FirebaseFirestore

class FireStoreManager {
    static let shared = FireStoreManager()
    private let db = Firestore.firestore()

    func getUserDetails(userId: String, completion: @escaping(Bool) -> Void) async {
        let docRef = db.collection(FireStoreCollections.users.rawValue).document(userId)
        do {
            let performance = try await docRef.getDocument(as: AppUser.self)
            UserDefaults.standard.set(encodable: performance, forKey: "userDetails")
            debugPrint("User Details == \(performance)")
            completion(true)
        } catch {
            print("Error decoding user details: \(error)")
            completion(false)
        }
    }

    func updateFamilyMembers(_ userID: String, dataModel: FamilyMemberModel, completion: @escaping (Bool) -> Void) {
        let id = "\(userID)" // Composite Id with user id
        let path = db.collection(FireStoreCollections.familyMembers.rawValue).document(id)

        do {
          try path.setData(from: dataModel, merge: true)
        } catch let error {
          print("Error writing family members data to Firestore: \(error)")
        }
    }

    func updateUserDetails(_ userID: String, dataModel: AppUser, completion: @escaping(Bool) -> Void) async {
        let id = "\(userID)"
        let path = db.collection(FireStoreCollections.users.rawValue).document(id)

        do {
            try path.setData(from: dataModel, merge: true)
            await getUserDetails(userId: id) { message in
                debugPrint("Getting user details: \(message)")
            }
        } catch let error {
            print("Error writing user details to firestore: \(error)")
        }
    }

    func getFamilyMembers(userId: String, completion: @escaping(Bool, FamilyMemberModel) -> Void) async {
        let docRef = db.collection(FireStoreCollections.familyMembers.rawValue).document(userId)
        do {
            let members = try await docRef.getDocument(as: FamilyMemberModel.self)
            completion(true, members)
        } catch {
            print("Error decoding family members: \(error)")
            completion(false, FamilyMemberModel(members: [MemberModel]()))
        }
    }
}

enum FireStoreCollections: String {
    case users = "users"
    case familyMembers = "family_members"
}
