//
//  UIColor+Extension.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 01/09/24.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0

        Scanner(string: cleanHexCode).scanHexInt64(&rgb)

        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }

    static var appBlue: Color {
        return Color.init(hex: Colors.appBlue.description)
    }

    static var appGreen: Color {
        return Color.init(hex: Colors.appGreen.description)
    }

    static var lightBlue: Color {
        return Color.init(hex: Colors.lightBlue.description)
    }

    static var lightGray: Color {
        return Color.init(hex: Colors.lightGray.description)
    }

    static var doctorBG: Color {
        return Color.init(hex: Colors.doctorBG.description)
    }
}

extension Color {
    static var random: Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
}
