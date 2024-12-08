//
//  AuthenticationViewModel.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 01/09/24.
//

import Foundation
import FirebaseAuth

@MainActor
class AuthenticationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var showingResetPasswordSheet = false
    @Published var isShowingSignUpScreen = false
    @Published var isShowingHomeView = false
    @Published var showSignInView = false
    @Published var validationMessage: String?
    @Published var shouldNavigateToSignIn = false
    private let firebaseService = FirebaseService()

    func signIn() async -> Bool {
        if email.isEmpty {
            validationMessage = "Please enter your email."
            return false
        } else if password.isEmpty {
            validationMessage = "Please enter your password."
            return false
        }
        let errorMessage = await firebaseService.signIn(email: email, password: password)
        validationMessage = errorMessage?.localizedDescription
        return errorMessage == nil
    }

    func getUserDetails() async {
        if let user = Auth.auth().currentUser {
            await FireStoreManager.shared.getUserDetails(userId: user.uid) { message in
                debugPrint(message)
            }
        }
    }

    func clearValidationMessage() {
        validationMessage = nil
    }

    func resetPassword() async {
        if email.isEmpty {
            validationMessage = "Please enter your email."
            return
        }
        let errorMessage = await firebaseService.resetPassword(email: email)
        validationMessage = errorMessage?.localizedDescription
    }

    func signup() async {
        if password.isEmpty {
            validationMessage = "Please enter your password."
            return
        } else if email.isEmpty {
            validationMessage = "Please enter your email."
            return
        } else if firstName.isEmpty {
            validationMessage = "Please enter your First Name."
            return
        } else if lastName.isEmpty {
            validationMessage = "Please enter your Last Name."
            return
        }
        let user = AppUser(password: password,
                           email: email,
                           firstName: firstName,
                           lastName: lastName,
                           createdAt: Date(),
                           height: "",
                           weight: "",
                           age: "",
                           bloodGroup: "",
                           phoneNumber: "",
                           imageURL: ""
        )
        let result = await firebaseService.signup(user: user)
        switch result {
        case .success:
            validationMessage = "Sign Up Successful!"
            shouldNavigateToSignIn = true
        case .failure(let error):
            validationMessage = "Failed to sign up: \(error.localizedDescription)"
        }
    }

    func signOut() {
        do {
            try firebaseService.signout()
            showSignInView = true
        } catch let error as NSError {
            // Update your alert to reflect error if used here
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
