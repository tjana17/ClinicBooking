//
//  FirebaseService.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 03/09/24.
//

import Foundation
import Firebase
import FirebaseAuth

struct FirebaseService {

    var currentUser: User? {
        return Auth.auth().currentUser
    }

    func signIn(email: String, password: String) async -> Error? {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            print("Firebase user: \(result.user)")
            return nil
        } catch {
            print("Firebase signin error: \(error)")
            return error
        }
    }

    func signup(user: AppUser) async -> Result<User, Error> {
        do {
            let result = try await Auth.auth().createUser(withEmail: user.email, password: user.password)
            print("Firebase user : \(result.user)")
            updateUserDetails(firebaseUser: result.user, appuser: user)
            return .success(result.user)
        } catch {
            print("Firebase Signup error: \(error)")
            return .failure(error)
        }
    }

    private func updateUserDetails(firebaseUser: User, appuser: AppUser) {
        let userData: [String: Any] = [
            "firstName": appuser.firstName,
            "lastName": appuser.lastName,
            "email": appuser.email,
            "password": appuser.password,
            "height": "",
            "weight": "",
            "age": "",
            "bloodGroup": "",
            "phoneNumber": "",
            "imageURL": "",
            "createdAt": FieldValue.serverTimestamp()
        ]
        Firestore.firestore().collection("users").document(firebaseUser.uid).setData(userData) { error in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
            } else {
                print("User Data saved successfully in FireStore")
            }
        }
    }

    func resetPassword(email: String) async -> Error? {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            return nil
        } catch {
            print("FirebaseService SignIn Error: \(error)")
            return error
        }
    }

    func signout() throws {
        try Auth.auth().signOut()
    }
}
