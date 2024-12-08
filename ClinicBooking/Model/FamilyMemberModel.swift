//
//  FamilyMembersModel.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 20/09/24.
//

import Foundation
import FirebaseFirestore

struct FamilyMemberModel: Codable {
    @DocumentID var id: String?
    var members: [MemberModel]
}

struct MemberModel: Codable, Hashable {
    var firstName, lastName, height, weight, age, bloodGroup, phoneNumber, imageURL: String
}
