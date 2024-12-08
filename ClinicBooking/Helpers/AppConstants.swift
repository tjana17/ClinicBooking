//
//  AppConstants.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 01/09/24.
//

import Foundation


struct AppConstants {

    static let serviceListImages = ["anesthesiology", "cardiology", "dermatology", "endocrinology", "general-surgery", "geriatrics", "nephrology", "oncology", "ophthalmology", "orthopedics", "pathology", "pediatrics", "psychiatry", "radiology", "surgery"]
}

enum Texts: String, CustomStringConvertible {
    case medClinic = "Med Clinic"
    case bookDoctor = "Book your doctor anytime anywhere!"
    case enterEmail = "Enter your email address"
    case enterPassword = "Enter your password"
    case firstName = "First Name"
    case lastName = "Last Name"
    case forgotPassword = "Forget Password?"
    case login = "Login"
    case signup = "Signup"
    case accountMessage = "Don't have an account? "
    case loginAccountMessage = "Already have an account? "
    case lookingForDoctors = "Looking for\ndesired doctors?"
    case searchFor = "Search for"
    case findYourDoctor = "Find your doctor"
    case seeAll = "See All"
    case popularDoctors = "Popular Doctors"
    case bookNow = "Book Now"
    case welcomeBack = "Welcome Back"
    case docBiography = "Doctor Biography"
    case docProfile = "Doctor Profile"
    case height = "Height"
    case weight = "Weight"
    case age = "Age"
    case blood = "Blood"
    case bloodGroup = "Blood Group"
    case familyMembers = "Family Members"
    case addNew = "Add New"
    case sendResetEmail = "Send Reset Email"
    case signOut = "Logout"
    case editProfile = "Edit Profile"
    case schedules = "Schedules"
    case chooseTimes = "Choose Times"
    case date = "Date"
    case time = "Time"
    case addMember = "Add Member"
    case phoneNumber = "Phone Number"
    case weightInKG = "Weight in KGS"
    case heightInInch = "Height in Inches"
    case updateProfile = "Update Profile"
    case bookAppointment = "Book Appointment"

    var description: String {
        return self.rawValue
    }
}

enum Colors: String, CustomStringConvertible {
    case appBlue = "#3E69FE"
    case lightGray = "#EFF0F4"
    case lightBlue = "#d1e8ff"
    case doctorBG = "#E9EFEE"
    case appGreen = "#3D887E"

    var description: String {
        return self.rawValue
    }
}
