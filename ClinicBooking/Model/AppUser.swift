//
//  AppUser.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 03/09/24.
//

import Foundation
import FirebaseAuth

struct AppUser: Codable {
    let password: String
    let email: String
    let firstName: String
    let lastName: String
    let createdAt: Date
    let height: String
    let weight: String
    let age: String
    let bloodGroup: String
    let phoneNumber: String
    let imageURL: String

    // Custom keys to match JSON structure, if needed
    private enum CodingKeys: String, CodingKey {
        case password, email, firstName, lastName, createdAt, height, weight, age, bloodGroup, phoneNumber, imageURL
    }
}
