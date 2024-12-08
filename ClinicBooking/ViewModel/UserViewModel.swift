//
//  UserViewModel.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 19/09/24.
//

import Foundation
import FirebaseAuth

@MainActor
class UserViewModel: ObservableObject {

    @Published var familyMembers: FamilyMemberModel?

    func getFamilyMembers() async {
        if let user = Auth.auth().currentUser {
            await FireStoreManager.shared.getFamilyMembers(userId: user.uid) { message, data in
                debugPrint(message)
                if message {
                    DispatchQueue.main.async {
                        self.familyMembers = data
                        debugPrint("Family Members == \(String(describing: self.familyMembers))")
                    }
                }
            }
        }
    }

    func getUserDetails() async {
        if let user = Auth.auth().currentUser {
            await FireStoreManager.shared.getUserDetails(userId: user.uid) { message in
                debugPrint(message)
            }
        }
    }


}
