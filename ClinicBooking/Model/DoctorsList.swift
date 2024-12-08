//
//  DoctorsList.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 03/09/24.
//

import Foundation

// MARK: - DoctorsList
struct DoctorsList: Codable {
    var doctors: [Doctor]
}

// MARK: - Doctor
struct Doctor: Codable {
    var doctorID, name, specialist, degree: String
    var image, position, languageSpoken, about: String
    var contact: String
    var address: String
    var rating: String
    var isPopular: Bool
    var isSaved: Bool

    enum CodingKeys: String, CodingKey {
        case doctorID = "doctor_id"
        case name, specialist, degree, image, position
        case languageSpoken = "language_spoken"
        case about, contact, address, rating
        case isPopular = "is_popular"
        case isSaved = "is_saved"
    }
}
