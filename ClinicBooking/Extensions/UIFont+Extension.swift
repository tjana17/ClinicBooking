//
//  UIFont+Extension.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 01/09/24.
//

import Foundation
import SwiftUI

extension Font {
    static func customFont(
        style: FontStyle,
        size: FontSize,
        isScaled: Bool = true
    ) -> Font {

        let fontName: String = "Futura" + style.rawValue
        return Font.custom(fontName, size: size.rawValue)
    }
}

enum FontStyle: String {
    case medium = "-Medium"
    case mediumItalic = "-MediumItalic"
    case bold = "-Bold"
    case condensedMedium = "-CondensedMedium"
    case condensedExtraBold = "-CondensedExtraBold"
}

enum FontSize: CGFloat {
    case h11 = 11.0
    case h12 = 12.0
    case h13 = 13.0
    case h14 = 14.0
    case h15 = 15.0
    case h16 = 16.0
    case h17 = 17.0
    case h18 = 18.0
    case h20 = 20.0
    case h22 = 22.0
    case h24 = 24.0
    case h26 = 26.0
    case h28 = 28.0
    case h30 = 30.0
    case h31 = 31.0
    case h32 = 32.0
    case h33 = 33.0
    case h34 = 34.0
    case h35 = 35.0
    case h36 = 36.0
    case h37 = 37.0
    case h38 = 38.0
}
